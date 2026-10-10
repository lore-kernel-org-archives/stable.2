Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA80337CD22
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 14:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791642444; cv=none; b=jqtIKzilLdn612jZskHfytI6xmD0BR8o/f0L+46efn6vdBk/qHAvJALQwV9EGdPFiKEbYhjJyUcU7r/9ksAhpHAbjkqJOtQLoOEEu+QnY2LXfmiRZlsM954TiTts+jEj4f9rlTWqzyzfxQt18Uxm0vOqo7E/swrtDulMnxMaBFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791642444; c=relaxed/simple;
	bh=grRLkJN+Ko2Iz6fCDMiPUA58aC5KdZux8G0S6xruiL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjok9O4lO1LF4RU8VZc0XbM+TrCrDZ+yy0vAXsSMvfhJknJtmucXo7+DDTaR9YRZy+jYm47lIqdY+vaxrOmCrbeY+4szdLIdlnsVTHyuE6Mvj8cxUqOeYa2dbiQoKl87S2fESPtLkdTc8s3AKNj0KUM+X8FZN11wbSbYTJKVz4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bj0UsI06; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bj0UsI06"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-7bf5f3736d2so424395137.0
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 07:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791642442; x=1792247242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=grRLkJN+Ko2Iz6fCDMiPUA58aC5KdZux8G0S6xruiL4=;
        b=Bj0UsI06z7aUcJA5nA09p3p0HYcZaakQ81zaETq0RVrBVSaC8d6c9UynDdmkUgon7t
         GjGWSfOhdofYP16sIroNbuoFJUtx4NWM/RNxfXYVzfn9+3bJPDBMDzLycTmxTy+u9nUP
         zHig3c8e604G23R8iGfhr0T4hnuc5HYipd1SupWbwutgaMgpRqcgGQAOx/gsF2mfhTX/
         /cks0RxV6lxv+/4iPFWkLhXmEkt1sjZiQ+XeBaeDR2mj7p10KPs9DD+TTBhwDMytFeZq
         wsA2MTXqXupqdVMdYNBCXuMkjVBCpUasrw7lMcVMRN77JlZYBTgXv0xvcYJUy1CX0Lzb
         0tfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791642442; x=1792247242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=grRLkJN+Ko2Iz6fCDMiPUA58aC5KdZux8G0S6xruiL4=;
        b=DdwliQZJK2HHsw9ZUfgiEFnU7Hcv3sXLc0qNVtlblUSH0AXj+VUl9jGFnaQl21DXLx
         JyT4h1zujlF1aFctffQX2TignnWMNfStYZWzWHNiQgUn1ieiefnWc/7mjizOcaiWI38m
         BkKELkh5OeDo3Tv99nONVXsZed+MkS9xEsql6c2OtcNrz1YSyyuZAaEG4qUFzglr/lme
         DHNvmF7QdlE9uDu1v9s/QOjCp0L67SfWojRcPj5yZGDVg5rfEFW3c+IJQvLUyBqmgAhe
         NnR32KzcVNaqNyU3qXPoeJQiTUwtcW+kYVeu0f6kA+kNePe6B4VSvHhftxgygwin4xAX
         vzVw==
X-Forwarded-Encrypted: i=1; AKwUvBxCAgOw63woZ/pCA/lXPEc04o5bJyVnLu1yT8ljh4eOFT42UklxzyRtpAxyZj6Qoona3S8m++A=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZHrTbAN5dYUb76AI1gZ2VQq48Hvx8SOpUwkDMqIuv1dQueyUz
	WkOD6rWeas4oMTfHZwQSe4GA1ugRn/TJoMZlms8OA14yKvX1U5/JdbQw
X-Gm-Gg: AYBFou14nwegbwEkYet+c2wqxG3V8QHAzUmWgnUtzHR5H09EUci4Kk4y+HHfpN4eZ/8
	TkX/ZNtJt/udflnXJgm+9MCH0MLKo1TYOv7f1HC+Oaj2m+ETheTHjq2iL11UzQTRaZFP/PrLMay
	8g3ZuQn75t9r1XTdSP778SKHbn/lUODVraDZExjvU830waRGrymgQI8nH1TeqNxBgMDy1g4jpf8
	mqHDbfl5H+Lz0Cs8FMHEylFz/darXfaZ4Dx9V7ZEAzUHCBJ5bqQ9BH1HCMHE+clFHKsQQLEkjxr
	cuA0DbOK6fsMtLGZNOUp2PWmhGWwL7HzNo0VSqvnRV8jD+dJw34E0eBJpqImUHUEv66h8yTusrR
	gG4Q333/2GG7nvadMbX8700booTzOUkwLsLXq3qUSihAZJzNQ794vXBrPHIHWOF2HXClKcE8bKo
	Z8M+UKCkVmbJ0edNAR7RD9EwO3TNkGOtaXe39B5F/e6zZGUArCV3Zrgl3D3a0Xrss=
X-Received: by 2002:a05:6102:9d6:b0:7a0:eb10:79b5 with SMTP id ada2fe7eead31-7cb37231b47mr1812789137.10.1791642442468;
        Sat, 10 Oct 2026 07:27:22 -0700 (PDT)
Received: from beelink.. ([187.13.210.57])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cb3411becasm3854339137.0.2026.10.10.07.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 07:27:22 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Kuen-Han Tsai <khtsai@google.com>
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Faqiang Zhu <faqiang.zhu@nxp.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] usb: gadget: u_ether: Protect dev->gadget access with dev->lock
Date: Sat, 10 Oct 2026 11:27:07 -0300
Message-ID: <20261010142713.2667481-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923-u-ether-gadget-npe-v1-2-ff466c55ecc0@google.com>
References: <20260923-u-ether-gadget-npe-v1-2-ff466c55ecc0@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Sep 23, 2026 at 03:58:36PM +0800, Kuen-Han Tsai wrote:
> Extend dev->lock to protect dev->gadget across gether_set_gadget(),
> gether_detach_gadget(), eth_get_drvinfo(), and rx_submit().

Confirmed against mainline. The race is real: eth_get_drvinfo() runs from
ethtool independently of unbind, so its NULL check and the
dev->gadget->name / dev_name(&dev->gadget->dev) dereferences could race
gether_detach_gadget() clearing dev->gadget. Holding dev->lock across the
check and both dereferences, while gether_set_gadget() and
gether_detach_gadget() now update dev->gadget under the same lock, closes
it.

The rest holds up too. In rx_submit() the cached g is both read and
dereferenced (g->quirk_ep_out_aligned_size) inside the dev->lock section,
and it is only reached when dev->port_usb != NULL; since gether_disconnect()
nulls dev->port_usb and drains all I/O before any gether_detach_gadget(), a
non-NULL port_usb there implies a live gadget, so g is valid. Clearing
dev->gadget before device_move() in gether_detach_gadget() is fine --
nothing between the two reads dev->gadget and device_move() does not touch
it. No lock inversion either: the sole rtnl section is unrelated and never
nested under dev->lock, and the guarded regions only do strscpy/pointer
work, so nothing sleeps under the lock.

One note, not blocking: the struct comment now says the lock is held while
accessing gadget, but gether_connect() and gether_register_netdev() still
read dev->gadget unlocked. Those run on the set_alt()/setup path, which the
composite core serializes against unbind (gether_detach_gadget() is only
reached from the *_unbind callbacks), so they are safe -- the comment just
reads a touch broader than what is actually enforced.

Reviewed-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
