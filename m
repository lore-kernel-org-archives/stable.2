Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793253725;
	b=YpzkN7oaeK5YQbQ/J0L9A5mQbiBRB7l3xLOrWh1KH0BTaU1K7C3Y5qJ4XsXUIiZgbHaG
	 PsxAy4S37czAPYZ8MPtEhBi+6fsBKCwASrHDtlgXngaplhG2UV0WpORYw8njO4iSwNnLE
	 jQW0+LWomb4l3IuFB2YBDgLpaXINd5f9lnEIlQKJ/WJmkBULPhp2tspUfEaHBMZ1+7zQv
	 LeG7rOOe3hVWVUj6oAukoTER3Rsa4zMazbh2ogu1PoaOyTR7LqXOaIWJlN0EhJIJRswas
	 ZVuax3z13plgaFUwxmz+RoAtJNtAjG/Nkz8WGReb013pYjSeAvPg1EHxQcx0SARL9ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793253725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Sender:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=EdAvBAcKZJXO5bQEx4evcyI+B32P4syy7lujkQHXbGg=;
	b=lE+yb2SKZAJDQkLa1ZHUKRAlkK23t7bQqYQ0f87Yx+eZutjcFIBNbDlTfI9cyOwCDZOD
	 S3o88UMxlTH/GIanAw/QSE2M+EdebxqgIQpEFS/5SUxyFkdOvR7xYAwYkmaY/W8qNjvJD
	 qoEXWFFYgPsNi2c8YG5wF8n6uJhIrHKJqbZau7TlMCXHrhL+q3dfJwvwSnQgx8/PBoR3G
	 CyOQP7FCw+Ms3i66aMGrnKxPEHbbqNcTFLV9TokX21nPDmIPPjbkQ96WN4kiF0yxQVNPM
	 BXMx79AY4NEQV0VUouRZyi4N/eKLO/mDCqjrD0YGndiAJIHJ5qOcvor0RLVzCbC8XTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=debian.org;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cpDEZWT0;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D5B606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 06:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17D5B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cpDEZWT0
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so15562215e9.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 23:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793253723; x=1793858523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EdAvBAcKZJXO5bQEx4evcyI+B32P4syy7lujkQHXbGg=;
        b=cpDEZWT0hgSN5bxsND+H+HVmvhlRTYmbsfLYWJlgj+j5CQHKTECdAoNRIKabG/brsN
         YYvzkjVzPxkAny9dEfvnIGkU8soU5Gdc4z6WK482dPcTuo07fVFo/I6MIIE6a+cehczp
         8oPuRsySj7m3EkpyOcB6eijJ6A+J9y9D8DAHA0noxVu6yDSKXntsbbYxKjd4MICjbhLK
         YgGQTbKDHYgl8tZdIKXiZM8SqHsy7gqlgV+H73ZaPyuEamFjZ49NVm2osJQdey0ZRxQO
         cM8eU50d/wYGUFoatPm4Raf2PbCXc1Zk6cyHvlbuScCEj9QtSmS4zW0amVrEMJYt7Cni
         NAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793253723; x=1793858523;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EdAvBAcKZJXO5bQEx4evcyI+B32P4syy7lujkQHXbGg=;
        b=FzFl0CabEKDlFGq28cc/Z5H9w92O3PPDx8ptXazZwprUwr5rz8Bbbk9xDn2gwoRsqm
         LT/DPGh+FeYX0hk/Ru1DiPiubdBxZSFTJLkLtkF44tMHlD09IZKAzBVepU0BzoVuSdmu
         I/lhw7xbiBgmRM3wuw4ubhxfHcVqyPl9BOSzjxsd8UDgi9CcTI/Z4y5SVNaQTXEahwMx
         nNvE1eGuuLTPeWVJeaQmSzYx3djk9QJi1xBUbHtZFwk7XIrMZx9N3O56KzD4Z7kUowBL
         yQjndXlhbwShhRJw+iEpS0WgWTnbzpwDbCIxrSP1SYcYPKIYNgzMQYb4elrrIP2MuPi0
         u06g==
X-Forwarded-Encrypted: i=1; AKwUvBzkurHpp5fRd8EzH7nv7rf2jF71xbqWuA0vi38007spn457t8XfAy/5gatoPFyPTCpLiuy03y8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLK5X3UpvXH0F349ConhOWdngi/psqfg30N/rlRx1krla5sEMDy
	eCey+yDsY+LAq/znuqAGFEWVULG5wawWZG2wezDlqRqO/XYhmlQRzqZT
X-Gm-Gg: AYBFou25qKAWyNXNKu5TlkjXvQYPRm58ttlQf/I0C7SZPzb1TB9bc7SxGNdmaOK4yVR
	pZv++A8lYEm1n0Yojm4NKhmABBwykY/4fYq6urJd1b5YzDwKCQFid3qwTQq3x00Zp4EopQK61aK
	40y1Eo/sQMnFuO52qlpmmG5SArH8eEUCVGx97aDlNW6EVfoZOeSPFDblVwRNrdn/NkRlbvR6Ajk
	y4b4Qjx0QNbPBiJBVGVdc5VO9tzuZtvkRCAHSp7KqWUvJJroR+iWjINKR+BYZ2QshfzzCu5aTE1
	5JFra9sy5JicgszCdBZd5TQrmZ4dkJn+s8qKFkNFmOQyRCXmJ4KJYPRsX9+AG8oIHkyJ26bFbGQ
	MhxwKeCzu/rdBYyHMPkNqZS7EGZysBMOKdADZsnL/pbpp+5RdSoASIoTQLv6mg/uRIUztI4O3xI
	0luRsRJ9msh+HEMACEL3OLP5PeYck/mvKr4KlmN55dkJqNyPL8F5INktFsXjX+BiK69Qi8524mG
	sRzYq/cpasn3MNfjB5qNOfAnojLYNz3ghH8M2gdBVCcdwQH3O8Pz5jBbGMvvNlYt9Y2g5omtaxF
	uKpI46FIhybpoENHhPUWsT7K6w9vfFMPrCUBJmJVjumEjfqJeEuEJexnebJEsw8Q
X-Received: by 2002:a05:600c:3b8f:b0:4a1:dbdf:17a8 with SMTP id 5b1f17b1804b1-4a9643d381amr107367955e9.2.1793253722974;
        Wed, 28 Oct 2026 23:02:02 -0700 (PDT)
Received: from eldamar.lan (c-82-192-247-196.customer.ggaweb.ch. [82.192.247.196])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a94f05e4e4sm64585985e9.3.2026.10.28.23.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 23:02:02 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 59608DC0300; Thu, 29 Oct 2026 07:02:01 +0100 (CET)
Date: Thu, 29 Oct 2026 07:02:01 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Christoph Zwerschke <cito@online.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Erik Brangs <erik.brangs@gmx.de>, benh@debian.org,
	stable@vger.kernel.org, regressions@lists.linux.dev,
	linux-bluetooth@vger.kernel.org, 1149377@bugs.debian.org,
	Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [regression 6.12.y] After backport of 980084de4d9b ("Bluetooth:
 btusb: Add ASUS USB-BT540 for Realtek 8761CU") bluethooth not anymore
 working on 0b05:1bef ASUSTek Computer, Inc. Bluetooth Controller (requests
 firmware)
Message-ID: <auLhWSOpMQg6cALq@eldamar.lan>
References: <bdafa01c-f75a-41fa-a264-407400a2cd81@leemhuis.info>
 <2026-10-25-1-daily-reply-0004-bluetooth-asus-rtl8761cu-hold@kernel.org>
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
In-Reply-To: <2026-10-25-1-daily-reply-0004-bluetooth-asus-rtl8761cu-hold@kernel.org>

Hi,

On Sun, Oct 25, 2026 at 07:29:50PM -0400, Sasha Levin wrote:
> > > If it helps, I can send reverts of 980084de4d9b and 6f0624b4427e
> > > (on top of bluetooth.git master, with Cc: stable). Alternatively,
> > > btrtl could fall back to the ROM firmware when rtl8761cu_fw.bin
> > > is missing.
> > I didn't see any regression reports for 7.x releases about those
> > changes, [...] So I'm still inclined to say: leave everything as it is
> > in mainline to avoid any risk and revert only the backports of those
> > two in 6.18.y and 6.12.y.
> 
> Yup, that would be appreciated.

I'm bit lost here :) Who is now going to sen the reverts for the older
stable series? I'm bit worried that it will fall through the cracks,
but at least from Debian point of view given we want to closely follow
upstream stable releases I would pick the revert only in advance once
I know it is already as well in the stable queue for the next release.

Regards,
Salvatore
