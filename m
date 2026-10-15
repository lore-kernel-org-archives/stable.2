Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0A155820C;
	Thu, 15 Oct 2026 19:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792093007; cv=none; b=VKomUEEL79qqvG+Z0K3txby4pmU+BzzwUVyiRtuVtXVn/qsfhh8f9kpM5ANFjP62L2nOypKsW/BeMFRu5DIE+v+bp2zH/oC6mEkayn4umKyBdUQBUzIAe055VzN4a7eB/LPX/0kj8nYaLG2n+ZWVUTy+1y9nY5IsxRTRp60vJeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792093007; c=relaxed/simple;
	bh=ZY8WDCEr1ZLqsPzdlEbCp8uH02JR28jrzCi2bCjcUMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPtygtfGFM/H7Ept+oJl5TDiUliTgMwCbHqFJm0rKeLQw8AqPRp1uSJmscdyz5frbbQhtSwE0gNPzEU9CdNIKUWlGwBsuRpH8D6hQiK76pQsGCm+j2IY335ZrMmb2Ve2WUyqKR2cPD1iTnSwa9WgYrOIx2VOGTwPMgAnoLQfWOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drMwZbZD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drMwZbZD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5B91F000C8;
	Thu, 15 Oct 2026 19:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792093006;
	bh=1z5Mj7Qv0mYk0cUgbxcksNvYokCdAeTNoA5oCpS1fmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=drMwZbZDNf5+SguqHmNBtAZ4xBACuClt1Kn5WP8X6OgHcKOUP4M4lyfztKSHJFWNw
	 yBOf74fpKVFidbWhQmjMn/a2ky6uZx0OE0ES2b7MkkfcsngKHndlmlfsitqVXkkQfG
	 RxPJ/ok3KK36BmFbmumSCMNfeL+84DdfCzggpOa90Y1E7F9GM+KgekTNP1QcBDgUJH
	 r/ULWLQClMqCocZqzFyrh7yx4ezGcDPFR/HSNpGpRhCizuDidaiAai7KSyF/xmRk1j
	 xCpDFGwZW0hPforQwl0rXRQVug/7hHzJu2uYab8ZGQG2gd2yaUg5OAXg0gaGpufCLz
	 sDP3yCR/TBucg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ira Weiny <ira.weiny@intel.com>,
	Helge Deller <deller@gmx.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-mm@kvack.org,
	linux-parisc@vger.kernel.org,
	"Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	David Sterba <dsterba@suse.com>,
	Kees Cook <keescook@chromium.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Tony Luck <tony.luck@intel.com>,
	Gyokhan Kochmarla <gyokhan@amazon.de>
Subject: Re: [PATCH 5.10] highmem: round down the address passed to kunmap_flush_on_unmap()
Date: Thu, 15 Oct 2026 15:36:02 -0400
Message-ID: <2026-10-15-1-daily-reply-0019-highmem-kunmap-flush-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015112701.650511-1-gyokhan@amazon.de>
References: <20261015112701.650511-1-gyokhan@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> We already round down the address in kunmap_local_indexed() which is the
> other implementation of __kunmap_local().  The only implementation of
> kunmap_flush_on_unmap() is PA-RISC which is expecting a page-aligned

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
