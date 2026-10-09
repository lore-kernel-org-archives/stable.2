Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E17F3A1A29;
	Fri,  9 Oct 2026 03:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791518384; cv=none; b=ojNpJhPwBXzLvoapr4topbtWY3nwB+relyb4iM/Lc8CqHtNRxdAJvF3xthFfUNlvDaAHppvIBo/tljAx8XvaZlRtA3j1emFY3BqX7jqwhwrkqacIqx+2mfD0oEbTCUBMUEEjju1fuW5G9X2gLAalyPhQQ6GWx8UdVwyUWnWwUMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791518384; c=relaxed/simple;
	bh=Sov9Tf6g3VmEQo++K6WTbwS/xsUObJTmQjGn5246zIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lsfomTxaLvjWMyFLU/AYwUXv2b6CDRPnLp4Oax6tRzV8q9NabiF6iGjze/AOsNQvKA8CWslSl1zFqE8EOM7hD631p01fXKMrkSgBjpOI6vWHbeb7VkNW7qHatrA6+o8rg+2k4xwEcm2SWYoH64r52zqyyZOSAKFZJjwcFk6mN4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=awDAwPgY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="awDAwPgY"
Received: from mac.lan (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 44E3320B7166;
	Thu,  8 Oct 2026 20:59:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 44E3320B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791518378;
	bh=6/TI13HFv+x671PGBKNgQcI39Y/yjLIx9UosPJ7tKh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=awDAwPgYb5jAwGL6IV3+Vknz4mPNrE/cbU1575lvCaE1tpLorxOPN2XzATSfZ8S+D
	 +tZI1GgBFYBRZGDgKkYoRpL3lQTQWR/OxVX8oUvlkj6hoZcHGJaRl4spm6OmTcp4K0
	 1vN2mevqmX6N91+UK8ozlFe2Wllw9E0e6QmKa9ag=
From: "Cen Zhang (Microsoft)" <cenzhang@linux.microsoft.com>
To: Cen Zhang <cenzhang@linux.microsoft.com>
Cc: AutonomousCodeSecurity@microsoft.com,
	Christian Brauner <brauner@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	David Howells <dhowells@redhat.com>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	tgopinath@linux.microsoft.com,
	"Dae R. Jeong" <threeearcat@gmail.com>
Subject: Re: [PATCH] watch_queue: Fix missing locking in watch_queue_set_size()
Date: Thu,  8 Oct 2026 23:59:13 -0400
Message-ID: <20261009035913.73056-1-cenzhang@linux.microsoft.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008224233.9675-1-cenzhang@linux.microsoft.com>
References: <20261008224233.9675-1-cenzhang@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> +	/* Use lock since watches may already be attached. */
> +	spin_lock_bh(&wqueue->lock);
>  	wqueue->notes = pages;
>  	wqueue->notes_bitmap = bitmap;
>  	wqueue->nr_pages = nr_pages;
>  	wqueue->nr_notes = nr_notes;
> +	spin_unlock_bh(&wqueue->lock);

I'll send a v2 tomorrow, replacing the lock with smp_store_release()/
smp_load_acquire() for wqueue->nr_notes.
