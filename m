Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D9E3B14C8
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 19:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786129565; cv=none; b=mTWwEYALGV0YVQMfifOtqR/+46kgWOYmvdZscxtklifjpFJAGt9akAFhHCjYM5sC64ZLLL6ZE4hqoInZDsrUBYywb2inKSkE5pnNerI+rbjg+oA2+eErNFusM8hPduhZZldVtajj59RGnXvKjhiJoZNLRv3awA9MIih/npfqZ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786129565; c=relaxed/simple;
	bh=hsST2Uymvd+H+wwXBLGix8l6UdAemhJiyT/ECq9AZ8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2PVWtgxJXQDMbHMy6DGnHXRxxuAbPS9soz8earRTvmGB8ZJwU87pSM7M6DRVs1SOndQ5EII9cjEfnnjFjMvScnzq6poOKE3v4ybc7T+JDgdT1kE7nkf1F+OKBgaU74ZYMihFagknDuxcO1Dmd6KtWAeW7UvaHdKjXB217wNJjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fH5nlJSm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fH5nlJSm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3B81F000E9;
	Fri,  7 Aug 2026 19:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786129564;
	bh=EygjdvsmNrxyr3T5o7HjUWupsJmCsD2O0s6EcHT9Zjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fH5nlJSm8NQOvvSln/Lu0FHChH7iVmmftIHqE19vEA5qG3swHzfgIo6tfESIJ5zPR
	 cITo039FZWjQGIuEcVcqCCrbPUsYWo3CwaIcoDENZvAGbNzB4UBK2ygnOFqI9OlfML
	 BlarqlLAcQUlji8nPN8sS0TuspZn6JbsYdI1aVTClEldU7LF6ga2R7I4aRus8e+kRJ
	 VTEbWl0Gzh6orlZZUdzcVbFBdlllNU5qRi1LNGU7H+khWQsPiBTaEnWNZJ/y3oVi26
	 6ljKgOK/gkrp2ZOOGNV726+h5MdE/2ZujkbJY7KkICnWFRxHwG5bFtvqEfvljpGd/t
	 8bed4yPp83o2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	kernel-team@android.com,
	Lee Jones <lee@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	David Carlier <devnexen@gmail.com>,
	Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH 6.1.y] Bluetooth: hci_conn: fix potential UAF in create_big_sync
Date: Fri,  7 Aug 2026 15:05:59 -0400
Message-ID: <20260807182230.stable-0001-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806221404.1172661-1-tkjos@google.com>
References: <20260806221404.1172661-1-tkjos@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Aug 06, 2026 at 10:14:04PM +0000, Todd Kjos wrote:
> [ Upstream commit 0beddb0c380bed5f5b8e61ddbe14635bb73d0b41 ]
>
> Add hci_conn_valid() check in create_big_sync() to detect stale
> connections before proceeding with BIG creation. Handle the
> resulting -ECANCELED in create_big_complete() and re-validate the
> connection under hci_dev_lock() before dereferencing, matching the
> pattern used by create_le_conn_complete() and create_pa_complete().

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
