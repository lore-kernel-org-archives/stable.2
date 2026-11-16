Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794792253;
	b=2HJoSGVhQnmd2xmgWPeLVIrYeO4N4nEDx5OM4Fh9FSRclUcof2tGw2GoFG+h95MLWuEc
	 WW+S5JJFaWQpIG8KlCbx1xuP7U7xYvMYXmoalBshpV6GnCi/+yvzdNAJaR8p7apnFAQi+
	 bu304Glo4jYIBSJ3pyDbeOo14euszgZDfF3MgFv+lKjjrFgkysJ1WOUQ/Mk0oeFQUU2JW
	 NeINNBUaS91XuhpxWjQixeqULS30Ulot8x1P2+wA3swu4XzATMoYPkbFianoow2fXjhzt
	 ABYgXCLohBsdPFxo+ptP0cinPl8n1iaSDZ72962h7BdjjGoxYbku2oaGDhpZBvNTDZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794792253;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=r7vL0qrifdEMu6hnfiQ4kzrLVyL8oBEHcc38n/hRip4=;
	b=id4jckYTTihTr9+0uc+Q4VS6FXwNo+rvdJ9AQztjLe4mhj+XMNERmYAM86VKUAxSz80x
	 vpBm7zUa4Xv/023QWCDOMUyhVeq3maMRGDFdwhFizb0xiYqPr6klwx2DmDDvmkSlniraa
	 bzu3WhgiyF+tQu6ppm47xVq+TdsebaT+QHRNaD7mfTXGtX78ooavR7b6PdJ/4W/XYSHxQ
	 30shq9oVYOUJVe52uz5pkSHSTcRMKgrab9vun7xxH173Nh87cyWC14KjkNMeWfwuZzCxy
	 p7aHjXPffiY5QxPPgJwVY+UJvabI0KGft6dzDoUGl7luQwlzOdEuRaV38lxw3eunQQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nuqJn7NW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59948606A32A
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 01:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59948606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nuqJn7NW
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-49412eb1474so1333996f8f.3
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 17:24:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794792252; cv=none;
        d=google.com; s=arc-20260327;
        b=rW9qa13PS8/oTsf7gydx8asTD0T7PaR9DIywq8174ZoOwLiXE0URPR85dzyg3u9vmz
         ndIu9vbxQCrmdhwM2xo0JTyjkSZDqEQw3vSF1FxUmpkTyk3DC/J3/Se+tTcgKqlOujT0
         THyJ+/npDmW19SSB66KO/jOX/F3/YaVVc57YWAJJ76/fDRbvdr+XFskexoeHBi5lSteu
         lxwTTl65gD3/HEnsMuu5uizfT+s9dNMN5Fxum5ohLyN9P9Puj9+Mf8A8QXrvn/sZKGQV
         n6i6Q4C6O1o2wwEbZN1pZlfN72RBRPNwPRzyCZ6d4mwTWUBij7zaDx1ufHziSTCH5dJv
         Z0sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=r7vL0qrifdEMu6hnfiQ4kzrLVyL8oBEHcc38n/hRip4=;
        fh=7LUG51yWlj1pqkQDl2x1DTKSvy6diXJMGZre3mwxbUs=;
        b=i9e7SpUHTbh+ISK9rZ/fm0VPO7w1ubjG4NTc4mJ34LhyiDqPW+0sIgp9xVE9mwAFcQ
         ByK1SgScDeufsqP7H7tqyTtXhAKYWxeqVSPSN4oMvvApN54HoIdJynBHwZ+6NPupFh3S
         dxBH9DYCO7VPZNjHFGyvfOlvqU3hVJyfACHd2om5BKitTcJRt2Cmmjn15NDrCw4M6vfH
         VD1dRl7YpprF6QvwTMggUxqicEMJYB/eTValY1kL4w6tmIN0f1bG6b9oN0vyVa8bOhHr
         P4jT53HPOhJEPPdMHPrh9Duh4jZp64uhZySmmCnZBlyCZtLsEs98+gyiVMB7KZL57Njw
         LlCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794792252; x=1795397052; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=r7vL0qrifdEMu6hnfiQ4kzrLVyL8oBEHcc38n/hRip4=;
        b=nuqJn7NW9lMUsb8EDML59apEX5MjFBCUyO4+WsSliUSLf/w30eKx99p2NUak/Go7wD
         ciipjVpQP0a33PbNJaixS8RQQi0m9Hu3KW0KPMhloSW1cHJTiGkRMi/W4z8/LQ5Oi0sH
         2zKeYRWXp4JU50GniIhhBKn3sMw6NPrwEwwD7hU2NBIV3OPQP4KHSOhRcAAywECIZh3X
         7cMo5FW7pZxGNoRjDGPhLYmEEdABgTFuGGKnEPFLjfJXqtqknznZm9gnB50hh9Bv9Eq4
         FRVG5k6J7WxTyJpvY4OylK6dr14BK1e5vtIc0oGn6gQCvt9kADZsT7WEVepqXEicQqj2
         KrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794792252; x=1795397052;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=r7vL0qrifdEMu6hnfiQ4kzrLVyL8oBEHcc38n/hRip4=;
        b=l3nYdL5JslePRmKTUafr+9KBqXDLqQSFf8E5LagMaH/CepwBC3FC8VPHyd13l7lk/z
         tG0IVZKI8imqqiFsJmrxl65IISPU6R4Ult2sGpyMi6plpoIbvcguduksLhH5yff2MDs7
         aUJfIxKs7BBHRsQvr3ChmX6n/PD3AdStdMVz5w+vBIGD6TLQ+T26uh61POYgELLokeNr
         Qxdxkwa1DjN1qcgrJ41mIFyatEybLZlH5aT97DIseRcACdZuw+K/r5Z+SuTivfGiKDX3
         EtCWgcS8AWxySQhY5IQEOTi3P/zgcEMrwv5HjOtNBNrv2XFGyZVMsYEjKPilfoASmU92
         LTFw==
X-Forwarded-Encrypted: i=1; AL+hErH3cLLKZDeWc3zWOg0PE8dEm3EFKjuLaBylurm7vpr3aYBQG2ym8V1f5soN3y64JaCLev4EDCU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Xf+vuTHwsCpNFjMte5Z7ECExI48vOZkfm+M8oLqaDDJ6IYiVo
	LxvtAIjYUu2irztsN4+O0ghJePZ8hovoVyDnHHJfnyLg2vGDSt9myul9rQuS8K+WEvxQr1YM9XG
	oAntBJcCqUcaarHCc/aOpTri+5Y25D2gOFnAYzOd8jQ==
X-Gm-Gg: AYBFou2TMvalXq6/EvnaOeovi0IcdIHqQwhm8RrKCWa19AQmOWp+q5DQ93Yg+SaEyJ2
	6KT9PsSQ/7Thx1F/V4Y79EW4tN9uXzXN+XDBsgATWjz8OVhAxZOdpYWO6pct/shhHHVkF4/7qD0
	54kpPJ62Xs6EKD0/j/7xSb5+5Mn+uMgzdJnZ5lDMeGnxefDqCQvH5DziIXTGNw+FtSQfY2F/fOI
	488Rp02oby4dnsUFPKcX2Oa0OwDP+kK9isYU8F3Ph5uqnFeES+MhXKERG4DCHbGrqwttm33vDkw
	+3FvUYFwPr6eEPUabNJwgGQt+OkqQex7lx/tcM+jwNE1R2hExDRSdsDO8INbFFd4lYFgbBaoqpV
	4IL2w5onpx0+Su0AoZckhP7O5Lni/KDGx8aQv
X-Received: by 2002:a05:600c:3f18:b0:4bb:6ac0:6dc0 with SMTP id
 5b1f17b1804b1-4bb6ac06e5dmr57112905e9.29.1794792251495; Sun, 15 Nov 2026
 17:24:11 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: william <assassinshalo29@gmail.com>
Date: Sun, 15 Nov 2026 20:24:00 -0500
X-Gm-Features: AclHuK-vjL1wmMPjBQCKuN5LdAtAqjLjQE_NAzaw7x4qYE1TjyXWc0GBGd6bI1U
Message-ID: <CAFjFWEjt+DPJ_gM1uTBZ_NoV6-3mi57ArjZ_Qdah2DqY-GCD1w@mail.gmail.com>
Subject: [REGRESSION] ALSA: hda/realtek: no speaker sound on Lenovo Legion
 16IRX9H since f2293e7b2ddd (PCI SSID 17aa:3842 shared with ThinkBook X G2 IAH)
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.de, evgeny@devduty.com, stable@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi,
Commit f2293e7b2ddd ("ALSA: hda/realtek: Enable all four speaker amps on Lenovo
ThinkBook X G2 IAH", Cc: stable) matches the laptop by PCI SSID
17aa:3842, on the
assumption that this SSID had no quirk entry. The Lenovo Legion 16IRX9H (83DE)
has the same PCI SSID, so its internal speakers are silent on kernels that carry
this commit. Headphones work.
Hardware
Lenovo Legion 16IRX9H, product 83DE, BIOS N2CN32WW
Codec: Realtek ALC287, codec SSID 17aa:38cd, PCI SSID 17aa:3842
Amplifier: ACPI TIAS2781:00 (i2c-TIAS2781:00 on i2c_designware.2),
driver snd_hda_scodec_tas2781_i2c
Kernels
Works: 7.2.10-200.nobara.fc44, 7.1.6-1-cachyos (live ISO)
Fails: 7.3.4-201.nobara.fc44, 7.3.4-1-cachyos
The 3842 entry is absent from v7.2 and v7.3, present in v7.3.4, and still
present in v7.4-rc1 and master as of 2026-11-15 (checked via the GitHub mirror).
Analysis
snd_hda_pick_fixup() walks the table and matches PCI-SSID entries before the
codec-SSID fallback. Before the commit, 17aa:3842 had no entry, so this machine
fell through to the existing codec-SSID entry
SND_PCI_QUIRK(0x17aa, 0x38cd, "Y790 VECO DUAL", ALC287_FIXUP_TAS2781_I2C),
which works. With the commit, the 3842 entry wins and chains to
cs35l41_fixup_i2c_four(), so the codec master waits for four CS35L41 components
that do not exist on this machine.
Evidence on 7.3.4
dmesg: "ALC287: picked fixup for PCI SSID 17aa:3842"; no "bound i2c-TIAS2781:00"
line (on 7.2.10 that line is present).
/sys/kernel/debug/device_component/hdaudioC0D0: master "not bound",
four entries "(unknown) not registered".
With dyndbg, after "echo 1 > /sys/class/sound/hwC0D0/reconfig":
hdaudioC0D0: trying to bring up adev
hdaudioC0D0: Looking for component 0
hdaudioC0D0: master has incomplete components
After unbinding/binding i2c-TIAS2781:00, tas2781-hda logs "adding component"
but the master still reports incomplete components.
Workaround confirmed
Booting with snd_hda_intel.model=17aa:38cd (alias SSID, handled first by the
picker) gives:
ALC287: picked fixup for alias SSID 17aa:38cd
bound i2c-TIAS2781:00 (ops tas2781_hda_comp_ops [snd_hda_scodec_tas2781_i2c])
and the speakers work.
Possible direction
Since both laptops share the PCI SSID, the ThinkBook entry cannot be fixed by
PCI SSID alone. One option is a codec-SSID entry for this machine placed before
the 0x3842 line, e.g.
HDA_CODEC_QUIRK(0x17aa, 0x38cd, "Legion 16IRX9H / Y790 VECO DUAL",
ALC287_FIXUP_TAS2781_I2C),
I have not compiled or tested a patch, only the model= alias above. I am happy
to test patches on this hardware.
Separate observation
After the workaround, speakers still stopped after some idle time. It went away
with snd_hda_intel power_save=0 power_save_controller=N and keeping
i2c-TIAS2781:00 power/control at "on". I applied both at once, so I do not know
which is required. This looks unrelated to the regression above.

I'd really appreciate it if the issue is fixed, as I'm now having the
same problem when the laptop is turned on after being suspended for a
while, and I haven't been able to solve it.
Thanks,
William
