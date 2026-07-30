Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120372CCB9
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419915; cv=none; b=aaWxARHZZMQz6xVKlGHpd2PorIG1L6qu0tzkr0Yx1Z3Vz2bzrw3R/+5MJZzlVv+tYGMDqsKghlMTEiFl7OVSGdHkas3keLujcsXBgIc0CxucM1zz77kLO8tT26SBQta1fmGQqVmCfAxtAQ6EGPJ270hONV2atwogB5W69rCbXME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419915; c=relaxed/simple;
	bh=AyDYZUkI4LxN1OwKn1gdfZzLnCy8TifSWUoCaFYc7dU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QohLmEkcXi66EUfwpBXx2j+jDQMvynEz8Q8rLG+UbgIiUol+Bf661HMRcRBHm5UrYvbg9kYi2gHJMdk8z6yEu5qIkC7EntdQekcLc8lEq///eAshJWTtz8TMev7z/CnToUuoJp5ngO7EGyjuT4UCQ/bKGX4VkkU0B6tuoW/T4Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cx/l9uME; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cx/l9uME"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c1600d040e4so115514566b.1
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 06:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785419912; x=1786024712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oeo+Ol5V0iJzFZJqhhNTD7gRBEjmwHyjPFI1Uq7A5sM=;
        b=cx/l9uMEzmG5GDELul4c0xZm8bJBUwBC/oBFFrj0JT8BGo5HLx5RTNLtwEc1qW1mHt
         FpB2bnY6QfuP+j8UzEzZI/avnbnr+5zXb/PUfhbc8fr4+B4n1XMCUng3RfSqlUBRHeiJ
         TRHNpV1LIoWsrlzbvbATQjiCWMEUwxLVbaayD+0Zfq/PIv43sa6rZFgQMNIYWUe28t3G
         6SO+Zo6d9KKRIv6praWI0xxgm9dN+EYYWHypBYQUDAjZzgTpF6513r/GbOIbuoqTZhtU
         E989Uj9h3p8WYtHOc0+pH9cFgwneb0PLJishQMCFExU3tN0ZEyxpWllNtv+ipAOj7FqT
         3Srg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785419912; x=1786024712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oeo+Ol5V0iJzFZJqhhNTD7gRBEjmwHyjPFI1Uq7A5sM=;
        b=cAOAoJSDwbwT+QgBV4KJ4/Doykc/+Gdgu6JuYaNgP+c0igabat1cMvC2tgrLYiYqfL
         y/CIAV107iXs4Dd4J0+gCeo3T+wqFPaOO+PkEMg3UuKWBpN53dR/bHY1B7yFoDVXLGKS
         yJuFDoJ9H6u+Zwb4OnAqgLr0nBTay4wxLsBcG9t2GpDX2RmbjrZqByeW/54gV5bhOG74
         1dbgSbZ/l0cm7kPheW+q515OX5MY5yavYs7dExKJqSMOHPfUzwLCM+RPh+H70+znIq3t
         2G9MSDIZUYEnl8j1RiLA0+KXElx5qbnuvqx78AXXICKRWbPrIEc8psxc4Se5cyFXK/5w
         KffA==
X-Forwarded-Encrypted: i=1; AHgh+Rq/iRbxNZj1jTKRUi/Eim2JQMAU5ceXCotkDD6LTRHvJkvyNtTGQixNMTb5Z1ByPgIGZWo/ows=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfx3KeZS8qrfo++UzEe1Am3C3rK5RkT0B30wL1kOt2+uoT4gtA
	zUZx6Ew/bOxlm6P+kw5xCRH3QY36k8ihEGzHVerH9A0lq08YmbkIllIB4ypsLg==
X-Gm-Gg: AR+sD12gaJ3BaANcDRG6NRkNQbk46TWd1BdQUqhNMcpr6m+E/oOokaRtP5aA85Y7X9w
	G79cyUfAwXIbmSJWPb+5IGvnYzJ3Z7hJL32FGkFVGWi0Q9H6MFVovfAkiRlWbGWGV0MSA7cK9yk
	7w4Nrj1eVKjbXu+OBdNibKJexrBBxiLjI9nRpi/mJGaIExb/zRBxfjg3DiGzHMtETvKei+lrjSw
	vKtahU2SSdyC4oVybGNVTrGUkhv9pLfQau2+PWiZuGh8zsJel1ZWDrOEoV4KE2mAMx9vATMPpmM
	Yl6/Hz4j7FJFj5mZfo0jmAJsipTTa2IrwdMK+ArypxKskxEmnuEQd2YYQJVKmnCe0zmymmIAY1a
	pZDjtam1LG4MpaCfvWfxE4Y9ags7V3Fd+OVxihEQFj2/jLWeu4U8DgYqbHAYkEuJqSFBPQJ1vSF
	25cC1Iq93K6ZsRfT31f49w5FtoYLyDCGHxtJDGAqfwOQTP3LnaYBZsKlAoslMNpcN7HeyHBiFGb
	pqyLcWRpATuJ1d2Yb6a38IHrT9K3ftZgvRT8RIpldDGx9bJ4Vmrb4NswePNOlRytpJ93WUbd93b
	cK5zH4MeOWDnNBorwxf1f24KWeYbJC+BZElt8R9X/sBQX+w6+yEoU6mqfv7K6F6BBWS1bmBEKBK
	hwRsfB4OmvVMGT8/eKwE4LxPTelMbmrMjpWSngSrHSTLXghevald4og4g+Q3pfpPuPjf6qUmGpp
	5oYR3C3G46A+Fw9smD+yoR47GBozaieMX1o0PillAXcEUPSmWO4JqDZ4eU5yaTHm7xu7+jjWkru
	y7BMA==
X-Received: by 2002:a17:907:d0d:b0:c12:8a:7d7b with SMTP id a640c23a62f3a-c1fbd180da7mr28571566b.1.1785419911910;
        Thu, 30 Jul 2026 06:58:31 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-b.c.oa7bb030819b2a894-tp.internal (73.138.178.34.bc.googleusercontent.com. [34.178.138.73])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa851d495sm69164666b.2.2026.07.30.06.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 06:58:31 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+eaa106d192c9daf37f95@syzkaller.appspotmail.com
Subject: [PATCH] usb: gadget: midi2: remove default configfs groups on teardown
Date: Thu, 30 Jul 2026 13:58:11 +0000
Message-ID: <20260730135811.1498-1-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

f_midi2_alloc_inst() creates default configfs child groups for the
default endpoint and default block using configfs_add_default_group(),
setting their internal refcount to 1.

However, during function teardown in f_midi2_free_inst() or EP cleanup
in f_midi2_ep_opts_release(), configfs_remove_default_groups() is
never called, therefore never dropping the refcount and leaking struct
f_midi2_ep_opts and f_midi2_block_opts.

Add the missing configfs_remove_default_groups() in the afformentioned
functions to free the structs properly.

Fixes: 8b645922b223 ("usb: gadget: Add support for USB MIDI 2.0 function driver")
Cc: <stable@vger.kernel.org>
Reported-by: syzbot+eaa106d192c9daf37f95@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=eaa106d192c9daf37f95
Tested-by: syzbot+eaa106d192c9daf37f95@syzkaller.appspotmail.com
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Aside from testing the fix locally with QEMU and the reproducer,
syzbot also reports no issues after running `syz test`.
---
 drivers/usb/gadget/function/f_midi2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/function/f_midi2.c b/drivers/usb/gadget/function/f_midi2.c
index 19fdac024..a4b72a6fa 100644
--- a/drivers/usb/gadget/function/f_midi2.c
+++ b/drivers/usb/gadget/function/f_midi2.c
@@ -2473,6 +2473,7 @@ static void f_midi2_ep_opts_release(struct config_item *item)
 {
 	struct f_midi2_ep_opts *opts = to_f_midi2_ep_opts(item);
 
+	configfs_remove_default_groups(&opts->group);
 	kfree(opts->info.ep_name);
 	kfree(opts->info.product_id);
 	kfree(opts);
@@ -2639,6 +2640,7 @@ static void f_midi2_free_inst(struct usb_function_instance *f)
 
 	opts = container_of(f, struct f_midi2_opts, func_inst);
 
+	configfs_remove_default_groups(&opts->func_inst.group);
 	kfree(opts->info.iface_name);
 	kfree(opts);
 }
-- 
2.47.3

