Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E520F3E92AF;
	Mon,  1 Jun 2026 18:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780337980; cv=none; b=HG/SGJ7HCNpklwXG8vp204tJzHJl1aPoFZhfl+Y5HkBOU2kQfitxbWoso6OuQ/E9IJzeEVdyuLS+Z4M18KFiGy5Ltcz8Ur6SquL6bBlu4Xa1F/LbIdDCWrYoefF+R17K6dqQWt8imybCZTiPoMqtWlvtH6+/cIFYi7CAl7NzSuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780337980; c=relaxed/simple;
	bh=8J1yCNlolIO9gvwOAIzRsx+cdIO+sxCl1+ec/CNaXR0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XhGTOCmg1/AEDLcEEnFCfVYMtyOsCTCgGvP9ziD9lcARrLU/iBaV4NF5Jq2bnjU+xQBHAR1uCRYyYXQC4E32qF/ZTbJCtpdzbDtPJIOp/XgN/JNbVp5GGIdlJkX/DjosO6+zxpXOaSzuTdaJm01GfGQZfJ/f/DhEmQDO4BAFxR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k48iIUhI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k48iIUhI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52DD41F00893;
	Mon,  1 Jun 2026 18:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780337979;
	bh=aMClyvQWifuvdGuk0d1Ko4JPGUZMiwKhVfICBAmE4Xc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=k48iIUhISuvEu3oWxPDZJNz+7F5hAb5SFJSWMDLHybsxZR2YD01esqnzYU7uLowIq
	 schKsSMNREJWO3YMoNOGrZvdFJtyEHFKbCvJ5GU/AQh7JGio5RtmLmj6Y7yQ5A8BRn
	 QP8WN8MKtS/00uuc//KDWzDHkRvdaCvO2AAB5T0i2SH1AHpMVXpX+KsLmegpgJ6EXi
	 zB32WLnJ+ND6epGBaqxqjI1EPxij5I1bVIERa1XZtU/elAiowRfr8KEqIXoL4mTPm/
	 1MjSRdjyvEMdASKNGRF+AaFULvCLZ6BNJk9Uw5zCiG4QTpEeyePuTGoEjAV98kE+Rm
	 va1HahRqIlUUg==
From: Benjamin Tissoires <bentiss@kernel.org>
To: Jason Gerecke <jason.gerecke@wacom.com>, 
 Ping Cheng <ping.cheng@wacom.com>, Jinmo Yang <jinmo44.yang@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260524135203.1996265-1-jinmo44.yang@gmail.com>
References: <20260524135203.1996265-1-jinmo44.yang@gmail.com>
Subject: Re: [PATCH 0/1] HID: wacom: fix slab-out-of-bounds write in
 kfifo_copy_in
Message-Id: <178033797809.14352.17153903990700437494.b4-ty@b4>
Date: Mon, 01 Jun 2026 20:19:38 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Sun, 24 May 2026 22:52:02 +0900, Jinmo Yang wrote:
> I found the following slab-out-of-bounds write in the wacom HID driver
> while fuzzing with syzkaller on v7.1.0-rc4-next-20260522:
> 
>   BUG: KASAN: slab-out-of-bounds in kfifo_copy_in+0xf3/0x130 lib/kfifo.c:106
>   Write of size 3842 at addr ffff888009179000 by task syz.3.9362/61135
> 
>   CPU: 1 UID: 0 PID: 61135 Comm: syz.3.9362 Not tainted 7.1.0-rc4-next-20260522-dirty #3 PREEMPT(lazy)
>   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
>   Call Trace:
>    <TASK>
>    __dump_stack lib/dump_stack.c:94 [inline]
>    dump_stack_lvl+0x97/0xe0 lib/dump_stack.c:120
>    print_address_description mm/kasan/report.c:378 [inline]
>    print_report+0x157/0x4c9 mm/kasan/report.c:482
>    kasan_report+0xce/0x100 mm/kasan/report.c:595
>    check_region_inline mm/kasan/generic.c:186 [inline]
>    kasan_check_range+0x10f/0x1e0 mm/kasan/generic.c:200
>    __asan_memcpy+0x3c/0x60 mm/kasan/shadow.c:106
>    kfifo_copy_in+0xf3/0x130 lib/kfifo.c:106
>    __kfifo_in_r lib/kfifo.c:442 [inline]
>    __kfifo_in_r+0x1b2/0x230 lib/kfifo.c:434
>    wacom_wac_queue_insert drivers/hid/wacom_sys.c:65 [inline]
>    wacom_wac_pen_serial_enforce drivers/hid/wacom_sys.c:165 [inline]
>    wacom_raw_event+0x900/0xa90 drivers/hid/wacom_sys.c:179
>    __hid_input_report.constprop.0+0x39a/0x4d0 drivers/hid/hid-core.c:2161
>    uhid_dev_input2 drivers/hid/uhid.c:618 [inline]
>    uhid_char_write+0xa8a/0xfa0 drivers/hid/uhid.c:776
>    vfs_write+0x2c0/0xe40 fs/read_write.c:686
>    ksys_write+0x1f8/0x250 fs/read_write.c:740
>    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>    do_syscall_64+0xee/0x590 arch/x86/entry/syscall_64.c:94
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-7.2/wacom), thanks!

[1/1] HID: wacom: fix slab-out-of-bounds write in wacom_wac_queue_insert
      https://git.kernel.org/hid/hid/c/6b3014ec0e9a

Cheers,
-- 
Benjamin Tissoires <bentiss@kernel.org>

