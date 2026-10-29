Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793267062;
	b=JIznN1u/1T9XGZpQf5CB/hxsup/F/VsFkZG4AvdAhdpd3999KwqPGzLj6leOI6Ev6v9c
	 l47F1oizvSqK2Mve4BI1Owjht/8a1YAdCfx9CQHvuYcQpACajDGuZOoiGTokXdu++SKkO
	 K0U7D2haK9rro4ZcE9/xgafkG1d6k8J8J/bGDweoMYeDgaYGZ1zxvoQukIxg9+tGF7thw
	 sz1Ic++vztsOIx204JswwLPAs7TFT4lwZxtv1D/2sW24SUOxpxIwiHqr42foslypy62Wm
	 3C4pASlWL2wlCMC59Vlq3fwQY9KyfFjy8RwVZ7j3jCxDVRHORJ5aL+BV+2YTtQyWIFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793267062;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UKSebZaSFVefMa83WA9Risb9bDftelK4ymQGDTUiUGc=;
	b=LpwbSyMA19JkabQE/qjAl+PDxclXIHNzMlEmj9/l6ul5YpS/2wQx+WfO70G9+AkdCBuK
	 1EwUnS4dU09rwbiDwfB3wARWP/GnRl6XcRDMllhMnXJV1bO1er5Lh30mWVr4pTKP0LdmX
	 88xYBp8/wPGnTRIKOyk50/c7TGeDCWyQqMWqGuJEYPa4J/hcBW2Q62DceVFFyYUnLZnr5
	 b/4nIkUsS+b29DSJLnGibcH1QfZjPkkqVm15LkuY+GDV5qWE24nASbWbCqma9BZUJhRib
	 1Hvtdt4gmN7m0sESjY+u1f9u7PYM+E5DmsCsclKI+2tWiQNt/mwaIcaIqZaQ/8ViJ/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RhUWxnDw;
	arc=none smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E34606A32F
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 09:44:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0E34606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RhUWxnDw
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cd5cd8d89a7so982522a12.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 02:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793267061; x=1793871861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UKSebZaSFVefMa83WA9Risb9bDftelK4ymQGDTUiUGc=;
        b=RhUWxnDwJvX15K7ipRR4XPyycz56J4nWxBJ9wQ+7eveSbrpw04HV1uu0M/TFmlJFmu
         lz0Yh8IQWBwf4EE41qfAD3bAIpcDW4vWPzANZwgbOIgn8rhNRIh+vxKHE1OH2Sii3drj
         1D9ouxhDZbqIFhW1+IUYbrnXkM7Xz9jbkkHOZ2LoBy9ZfSDgFETK+iOTjip9E+kholLQ
         oxQmFNP2JgK2m3UOLr0n1jREU+DEtFBd8idnQhSc3UeYOaw2KEk9HtN5Yc9roucMviUc
         lErwfgPN1F3zlPe834PQmwHx3H5ARm6HXu48UzJQYYsr+Y71lX8bzBgpV6ewGH8GTH/Q
         13Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793267061; x=1793871861;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UKSebZaSFVefMa83WA9Risb9bDftelK4ymQGDTUiUGc=;
        b=NKh2XiVcRkiVafFWJOr4zwIQSH8dm8eE2Ruu5kBeboL5zhSU6caz7TUgGGWYO4g45e
         l7mZ65me43Nt2qrwj3v+quucIn1PJkLB2Rq0iyNCuIlkDJELUkvaKtVQIMJj8x7TdH18
         kZWyTVod+2Bv39M73qYXX27U53cZ6sRSWkcPCo359hsgqtJ+kybYNgTxEoACWQl2BEQz
         5lXEXUyJsMo/8fuaAdGT+dY5/oNfTde+RBg46xljHGqeNy/1vVY4c57XyDg9z4nbQXBK
         K+dlZXZO/uNwDSlF1rNMna9I8NY+3toRdgoxk7jsQqHpRQAwof2UeuCTECghy//lpFQf
         Qxog==
X-Forwarded-Encrypted: i=1; AKwUvBzRkxjbXeEKynEFMDvZ/LiCOwu1m9foznkJTi/YKnxAje44Keov0fCVvhY78qUZ7v0oek0qscQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKnAP1SeREdu6wNjuHxbJ6e/zqNxl9UbqH9LhNpjpnUBMLal/mi
	NusNc8oDugVvd6+ghECMamnJ9rgmu8La15pWL+hw79vsTNhEnlJ7xaMRino7d8EVpx4=
X-Gm-Gg: AYBFou2p6PfjVNmMH6NgccuysuAEs4wv0ZH2744L+1DHkDbaoXzfzJb4sEPkjXEy3ib
	4/OROsU4Nd2dyeBCIeV+MVkFQoZz3q1PfIsPGLB8jnyFlDjJIclAiUXIx27jUrZUutbvHBnTZV2
	Al0nFBJDRh9TtXGqxubDjlRoli728KmOgDsYFB9qZeOmtjpdYqAvXIy11Er/3voo2POl9b2w/KC
	hxLfOdKqN4UcPW2szHjJ3h9mmp0aX2yfB2NuCskL2CsMCMKxkHCDlykix0wzBtSsIzIoQ8oO4vn
	0NUKnG96RgBoyheBxr1ZA8pBHHZUMufqkVmvqf+S1ch2+rHggcSFLuYR92+LOlboR2XFv3us6+7
	IPKRz+hDmVUghE9S8B2N39pQ8edowULQNpuBlUdGiNAejG3my5Gm6I1BWXv7GwVk3+icaIZ85Vt
	3K06zDP3Tpz5eUALewDGO1pK0jKCRtoJl4Y2Gwj8vTg8TlifE46+o63mJwQjrOki0HbJMEWGXyx
	MSC62/9lNDQdo9UvT9uJkf5TcOsMkKu+GwhLaKdt8Zp/VL5OYWRnsoOOgGy3uqg9EUCmdYV7BXu
	a0B4AdhjUh0fVeIYJDeUEoiFAamcn5WLPx2bSfiZKwTgiFSdi3xHJVGv6LxtWh4y
X-Received: by 2002:a17:90b:4b89:b0:3ac:17c:6e85 with SMTP id 98e67ed59e1d1-3ae581e1959mr3851734a91.47.1793267060784;
        Thu, 29 Oct 2026 02:44:20 -0700 (PDT)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae579c59a6sm2912203a91.3.2026.10.29.02.44.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 02:44:20 -0700 (PDT)
From: Zhao Li <enderaoelyther@gmail.com>
To: Stanislaw Gruszka <stf_xl@wp.pl>
Cc: Wey-Yi Guy <wey-yi.w.guy@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: iwlegacy: unregister the LED if 3945 hardware registration fails
Date: Thu, 29 Oct 2026 17:43:37 +0800
Message-ID: <20261029094336.19250-2-enderaoelyther@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029081955.GA10212@wp.pl>
References: <20261028142328.18560-1-enderaoelyther@gmail.com> <20261029081955.GA10212@wp.pl>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Stanislaw,

On Thu, Oct 29, 2026 at 09:19:55AM +0100, Stanislaw Gruszka wrote:
> On Wed, Oct 28, 2026 at 10:23:28PM +0800, Zhao Li wrote:
> > il3945_setup_mac() registers the LED before the mac80211 hardware, but
> > its registration error path does not call il_leds_exit(). The analogous
> > 4965 failure releases the driver and reaches its existing remove cleanup.
>
> Could you explain exacly how this is fixed in 4965?
> I do not see this in the code.

There is no il_leds_exit() in the 4965 error path itself. The caller
handles it: il4965_mac_setup_register() runs from the firmware callback,
and a failure there unbinds the driver.

  il4965_ucode_callback()
    il4965_mac_setup_register()   /* il_leds_init(), register_hw fails */
    goto out_unbind
      complete(&il->_4965.firmware_loading_complete)
      device_release_driver(&il->pci_dev->dev)
        il4965_pci_remove()
          il_leds_exit(il)
          ...
          ieee80211_free_hw(il->hw)

il4965_pci_probe() returns success after submitting the asynchronous
firmware request. If the callback reaches device_release_driver()
before probe finishes, the device lock serializes unbind with probe.
The callback completes firmware_loading_complete before unbinding,
and il4965_pci_remove() unregisters the LED regardless of
mac80211_registered.

3945 calls il3945_setup_mac() directly from il3945_pci_probe(), and the
probe error labels never call il_leds_exit(). ieee80211_free_hw() then
frees the il_priv that embeds il->led while the LED is still on
leds_list, so the next led_trigger_register() takes the trigger_lock of
a freed LED.

That should have been in the changelog. I'll send a v2 that spells out
the 4965 path; the code change stays the same.

Thanks,
Zhao
