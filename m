Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793642661;
	b=gWYp+7osAN+bvNhG71t/op97aiYrRAvqy9t4RnW2at67v4B6/IwAVqNjeDvv51hA8YHr
	 Eu84cq3EBmZAFEIVo3LH1XmwR4WQdMLXNT5JnqqZtF+QTzdbZJ4+clQjSPgxCxWxjMyBu
	 hpB8i/+Y5PX7M4Ywi189KWjJvhW56l1s5tq1PC3wNN9IClwkgsZczaIuAcgW8Btj6to1z
	 7yNuWfyI9Dp1i8kmrNkMxvYl6z50ybfWx+vnRDtKxlpg1o5oVT6ilvVYipiBV+LF8tCt+
	 TgTb6VFmySX0A+PH8uDV7LP1UAG+ThcSlyp/HWEaR8l9fZEdac+hHG/A2bk3PUwGSQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793642661;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
	b=k67Uqur/7Db1kM4dLrD+oC+F20ACbtFJ66369bOMoybLFPTA+XpYhx2F5uYPbqJXvMgE
	 gnpjuQUPtGwjBEtmu9FMznFmE6yKVhsl7KQtnBNICrpG1BvtBw4Stoz+dZ+7nE0wnPATD
	 XYpFuKwZssNk2Ocj6si2ch0Li+AixIvKzIlRbkZflfjyNFXcBj0wMESx+OGNE7I13p5KD
	 UaWzI9h37QAfI3vXUdWDRhW3rCFDdtnNwvCRbNEByCBHujOeUJinupHUoumfquF+Q81gu
	 ElJJ+ugzmQzz3xXSELtfXdoXbkHuei8YiNYI6kFIUpcOeYVI+wI2TfzPcKfj/S7x9yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=OORRqZXu;
	arc=none smtp.remote-ip=209.85.167.53
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20932606A595
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 18:04:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20932606A595
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=OORRqZXu
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5bcb440d1cbso2154454e87.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 10:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793642658; x=1794247458; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
        b=OORRqZXu5svxsOkxP9nvh3W+PSYogrqOej3+5tGXfkVuzUkf2X8/W+m3oNpBLcCZfe
         SVjygfmGaUx0KLZac6oM41ZS2kLSSwldlLr1kcXsC2ZmsDPhqGc6IMeHwX7XaZlR95yn
         dyEjwn/f15euAVXzslwr9aSuUnHQwPwO5ARNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793642658; x=1794247458;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
        b=sCaNiSKQtmIBY3j/8zOVhiV8P7gJV9Jvtv1nL7DlA1uq45NNeKfFUfSR92Q+1y7vzq
         jii2ENRSpA5knsDt4UStf2X8cwyN5fffJMBeykxQkt5qRtgDBCQD0mZ/ZZfjtuakOKd8
         KqBVk05Q4aBfWpD/zzBRVROYT+3wRUDXqtkFpO5V+rTwvkwuG5BZMW1tEfdQ11Dz+3VM
         jpdzyNDGsuHjoOFcAi7abDvwotmEvSo/7g7rS5XJn+1leLxRPSdVoqy/4TEeZQvcaBgK
         y8A+w2eJ2cByJE49f/5vPRYlx032hch7OUNpN/hRANS4Lan1K35nMf3ZlU4Th4Jvlxff
         SobQ==
X-Forwarded-Encrypted: i=1; AKwUvBwpJBLSzE3AT6Kp+j0ajxmgsMo3oNabXxv+yOaezuJ8fUBIKGKcPNSVduLuGu0Cu+EJU7yP4EM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+08ISOCwBztdJErahW1JmVzNKlj+5TBibm2IEZtobETzb47WjL
	QBw7ovW+afHks1EBIPHngK/sg+qtNKbWYTlYLdrWg5LQqAoyUAdMuo2JO/lAZ1N48eQKHjEL9CO
	O11+H9o+SNg==
X-Gm-Gg: AYBFou3ty6KM8S5rJO+W1CRc75mRkitzYF2GRpoZBXFpqcSpR5NfksUTCIiYE8TaDJv
	zodG2iN/gv/qU+yNL/40MdJhW0UsEEL9Fpax29j7vMa8VHfPlAYEWR01DjTShMKvb4ghEYw14cd
	Od4TKR4I7tkKjKgWRBXhzDRGmJ7flatt+SOPVrKI1THhyCgB69qBPW72kSxyvUfKEoa3v7l2dOq
	DLinenPApu7iHa3FSg3yooa0dRUDSYUvZlhbPGCDl/bhg7dvnEHPswNG2sMvRbtCXElS7uG5SuQ
	hgl28J5R7QNev3yQ5DhDX58TFWIx3ULYfpGEX1dMKxxlYarBQImcsFLP5pJ0oo+gjZ+DqIH28NC
	I+Du1bm5i0TctJyTHlx6K5wR/Qw7RtCOj83nsQ5T/QFO4+TsdFO/7fgNIZvF4ngzVoLHIjzVYpd
	PEhZgH0PwcQxZ1ny1aR7ivc5hXpLq6R00EfXyX02Pdrzf8dCzX8soAD5rtozOJ2CZK1t0FLDab6
	VCPI2Wi9pWwusTR0H1jQU+AfumXZDziQTFtNMfSXRX9WFtUdJBs8/P/YW9L1n07d/raXxyV9523
	7pK/IY+wdK4Gnn4G+jn3LRnaPEm4ng2FCUKvTayQqfjnKb1glIHud9OBrVsRN7vFblzdaHTwpM7
	aVA==
X-Received: by 2002:a05:6512:6d2:b0:5bf:d70f:2d99 with SMTP id 2adb3069b0e04-5bfd9564f92mr3140066e87.7.1793642658098;
        Mon, 02 Nov 2026 10:04:18 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfe097435asm1746530e87.53.2026.11.02.10.04.17
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 10:04:17 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5bfbc25a76aso4761993e87.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 10:04:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwYMY1rJjErRxeyQPX70jhQSxfLpT3YiB/8xWmY+eRGqKhLyHHvj9NcjfUllEbss6foxvyj+Sg=@vger.kernel.org
X-Received: by 2002:a17:907:d94:b0:c2d:c80e:8366 with SMTP id
 a640c23a62f3a-c4ca7426f6emr874452266b.0.1793642348398; Mon, 02 Nov 2026
 09:59:08 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org> <20261102-work-procfs-bugfixes-v1-1-59422ed3e465@kernel.org>
In-Reply-To: <20261102-work-procfs-bugfixes-v1-1-59422ed3e465@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Nov 2026 09:58:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiSA7-mqmAjTQDaU7UjUyWt0TxYwXHafL8ZAPudy+B_uQ@mail.gmail.com>
X-Gm-Features: AclHuK_qZTBVsLQIdymgRHScSFenC6XsGggUDmcuOugjrSTbuVkeASUmC_hYPZo
Message-ID: <CAHk-=wiSA7-mqmAjTQDaU7UjUyWt0TxYwXHafL8ZAPudy+B_uQ@mail.gmail.com>
Subject: Re: [PATCH RFC 01/38] PCI/proc: don't truncate the position of config
 space accesses
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, 
	Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	platform-driver-x86@vger.kernel.org, coreteam@netfilter.org, 
	kexec@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net, 
	jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org, 
	linux-sh@vger.kernel.org, linux-usb@vger.kernel.org, 
	samba-technical@lists.samba.org, sparclinux@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net, 
	Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Nov 2026 at 06:22, Christian Brauner <brauner@kernel.org> wrote:
>
> proc_bus_pci_write() truncates the file position to an int. A pwrite()
> at an offset like 0xfffff000 turns it negative [..]

I think this would actually be better with rw_verify_area() just
checking a per-file maxbytes.

We already have that logic for lseek and friends - using that fairly
hacky combination of s_maxbytes and !unsigned_offsets().

We should combine s_maxbytes and unsigned_offsets() at file open time
into f_maxbytes and check that not just at lseek but in
rw_verify_area.

And then things like proc_bus_pci could set it's size limit in one single place.

Hmm?

                   Linus
