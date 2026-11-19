Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795073184;
	b=rAD9J702yf2dBPKdhOAY/PgoV2F9iXY6VhF/+IibBweKUqLiAxJu7jux8R22jbG0w2A0
	 TlFsaFnW0vpgop2KLsc1CEJVf5a2pfRpPAPrJrBDaFD2EJsVHBkgfKo5IXMQLPcOesaUu
	 5RkiHUVLcmyLmsxeQGPUk6iIe9jAN4TjPiTJzJ+ItkzEwVEVlSNy03gvxO+LuUfgExaOT
	 sCQ39cGwpDGl0S/s9Qsv0UwImOSO4CRxWHKXwi5vxxzDt8JBHCkzvJyJgKZJZTS5Zd8/D
	 Lomm4k92UIYosCD5apiak5VP8EF/TErO6xbZj+cC1WpaSeOjtklcoqfDvwIVda5DQ3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795073184;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Disposition:X-Mutt-Fcc;
	bh=3j6KmbtXLvsmTJiTThzFS5hiEYdNxo/Fgv8rfbB+Ypg=;
	b=SETmJm5nmdPTIn+EpN/hXc0Z+2d1+mTiWvjota1Tg8lrcbul6ZIuZNJ3HYb9L9N542BY
	 wi8rZEcvfJc9NEFbTYCV+LNJbFW0x9FLLKIKFsu1KyOGLG728EFy2TXAjDO9HTVdHg1pl
	 G6tmQG/I7JVXU/Ju6bgaJGC56Nsj+FK/AwGukfDBgUths5k05wJiWrOF6Po0HTlYEX0US
	 8VYM+88nDBmzUTQXj9BT94Liy+yByTxMvEOm7SKEDQ2QePeU7IoZoohw2YeTugyj0tWZL
	 r8qJdZPc7xdqwmOxudRBhR3GREKATGxtwa57w62ojXHDr2ArBnuQsLHxKIscFPaZpGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c70w9kVd;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=F7rRIAyt;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141D5606A335
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 07:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 141D5606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c70w9kVd;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=F7rRIAyt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795073183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=3j6KmbtXLvsmTJiTThzFS5hiEYdNxo/Fgv8rfbB+Ypg=;
	b=c70w9kVdENByQp5gaWTGVw9HtxsZcdVMRWaTJWqnwsgOT1FJX2hCQJyDAgFLjrz3sPNQ8T
	l1HLd7fBRgwHbjgiUPDbJuLmHm3HHZLcZCC7ggy2Mua0Fl25BzeOfEHBQ7Q9/Mf3vsGRm5
	DQIDfiqp4fxFjyto/MvpPrRiQSD0OB4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-kWOKzBxfPQeA0FuQ9Xbfpg-1; Thu, 19 Nov 2026 02:26:20 -0500
X-MC-Unique: kWOKzBxfPQeA0FuQ9Xbfpg-1
X-Mimecast-MFC-AGG-ID: kWOKzBxfPQeA0FuQ9Xbfpg_1795073179
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48e29c25101so874964f8f.3
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 23:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795073179; x=1795677979; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3j6KmbtXLvsmTJiTThzFS5hiEYdNxo/Fgv8rfbB+Ypg=;
        b=F7rRIAyt3wWCkr/uIq7CcsZAeA9N2ckYQaSb9PfrHzzdrhLoatK0jPKUtp+a7bx4zw
         Ke1VCtmj7C1COq4SH1DMhKo2Ccl9K7tOI42jExCQFi7YHv1F+j0DeQnYLHFOJllMVk5T
         t2Hal6qIZufy2ggOPnNvB12f4qax7PvUPO5vOts5DVv1q8s8jnGomTr9maN07NLHj81v
         GsL59um+fiT/322vCvC1fsnbBl1QmFpLuvWWvkOEpUPm4fWEQ51aFMUTyFQ7v0lGn2U6
         ZCM/9e2zx93L7vZkG4kMo77jDjMqrJlJiTu6EWtXGU/v1melySXVeVmdbJPyQnN6s+gP
         LWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795073179; x=1795677979;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3j6KmbtXLvsmTJiTThzFS5hiEYdNxo/Fgv8rfbB+Ypg=;
        b=sQlg6n/5gMiy9Wo4tPMvl/Al6CoWgieEjHmzYkY+cOjx8rax1LrAmxeTzp2hDJzkNd
         nlHt1FjNCOQI8vnPXRT4rPCARzoidgG2YwtrjD3gM7pgaiag0ayf7UEB5IO6q1scCfzU
         zmHb9FuCauy3GDcSB17SOhzzemNubN7PxEGz+MiXGryN7h6SO8+BdsxMP8FC0aqAuq1l
         i8m3hXQYF5AAxlRyHR1dz0RBDXPyRWxXe2MiNdl2vPWg2JiEIehlRIr5i+5cgOsyB52S
         uF7c0e6brcxbgKnKPz59SbTrDSddWP7lejx5AhR+CCrnHnz3Qd79YNlrVfvq9r7Z/TpZ
         jTNw==
X-Forwarded-Encrypted: i=1; AL+hErHQXOqP+82/4PhsuK7IZN55G5Lfm8q1yjUbYPiMEnvDpwj+ctzpHf7ZJSrrsQgP1+LeuGXGkcs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+dg1cnEslsd47XrqvkAzSkTqtikLwCSd0o+tBPtD9g1GRCNLu6
	MA1/jV31neID/tjo3+kLdlczWabravE+j8IosK9Z7rj5LOq/rF60AcMW9Rz3ii4qrm8PFI62s19
	vj4naMVpgINBww4+KTyCiziE4CDVoXu8X1shg1uKKuHxDeiQnDcdtcdUUQQ==
X-Gm-Gg: AZFdTZdA1OdcCcyYTXmAefq1cqVKFQBFKc/4NjmgM2o0nVX4LsTNd+ZAPxZwe2Bz7zt
	ynF3NZ8VUchnK9/BQdrtoDmW15KCa9rcC5sUmfIfSF2b/ZRJEHKE4lYwgaig1GJ0RrgUHRADT1h
	uR0jBGCetlCyv138/Gp2/7kt/lRDbqDpsUlH9mJDMFMqHtAV/vSZWsp0xIERXnw/8rGqR1G17X4
	V8seO4tpPrSeLYFMHM8AmnnaInyO2u+dX6caiaVe2revgj1opiqx/efSmGj1l3egfy/Ejk2fRy4
	a61j5aqlO30e19znK1WsbRVCg1Qtj1BokEG0+iEAkJ+PlyXA7Ozc0VlBX7ZGRw201uvLoqfEKxA
	rnmLYLL0/c6HtmSrTXWjjk9cOFdGYWG90G1twnN+Pm5A=
X-Received: by 2002:a05:6000:4703:b0:4a6:4f35:336b with SMTP id ffacd0b85a97d-4a64f353379mr8871403f8f.5.1795073178857;
        Wed, 18 Nov 2026 23:26:18 -0800 (PST)
X-Received: by 2002:a05:6000:4703:b0:4a6:4f35:336b with SMTP id ffacd0b85a97d-4a64f353379mr8871351f8f.5.1795073178254;
        Wed, 18 Nov 2026 23:26:18 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1520:4400:d78d:7b2d:2f5d:e08f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a65541f3f7sm9540259f8f.24.2026.11.18.23.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 23:26:17 -0800 (PST)
Date: Thu, 19 Nov 2026 02:26:15 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bioloidgp@gmail.com, jasowangio@gmail.com, minki@morningstarsec.dev,
	mst@redhat.com, stable@vger.kernel.org
Subject: [GIT PULL] vhost: bugfix
Message-ID: <20261119022615-mutt-send-email-mst@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mutt-Fcc: =sent

The following changes since commit 1a577f9402c1780cc1e663f48d5dd54c02051b09:

  virtio_pci: don't take the MSI mutex under cpu_hotplug_lock (2026-11-03 07:32:14 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 5570a998b884c988dbe105430d7e2d8e9411e37e:

  vhost: split out-of-order used ring batches at every wrap (2026-11-12 07:44:36 -0500)

----------------------------------------------------------------
vhost: bugfix

One bugfix here. I am testing a couple more

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Michael S. Tsirkin (1):
      vhost: split out-of-order used ring batches at every wrap

 drivers/vhost/vhost.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

