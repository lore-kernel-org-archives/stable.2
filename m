Received: from va-2-58.ptr.blmpb.com (va-2-58.ptr.blmpb.com [209.127.231.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBE83E559A
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 08:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785916897; cv=none; b=k9buQnMq6L3Nbgf4sk8sq3veBVrSWq03kKD8RFiaIO9IpFNARfJADKWBZC5/0+cU2CH4AmxXM8QhPiqS32JKfzcOkJ5qk+D0/ilSqzvRBhDO+qGmEp/9Q32lVrvXIaOnFql7NK9+vL/k8cCMUOCGH0WvzaJkG5lOWkbZ5/Unbcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785916897; c=relaxed/simple;
	bh=5nbgeTlwPmpvxBjsWXUMA4e+lDFnLr7P4RDG2gdlXMs=;
	h=Subject:Date:Cc:Mime-Version:References:In-Reply-To:To:Message-Id:
	 Content-Disposition:From:Content-Type; b=hPsVzDwr0dyL+NMDESvG2Dnxh3f0cZnAcJQqEV/PD0HmnwNm2W2IfpElcbWnWyeoRUK9w//dqpJ+wfSf9rvYqqKkw5qNymT4VNXf0HFTXE0mtfWndAvHGpNvtAnkCODu2zxtct3pJW4NQtOBSmzf1RGMzUR4GeZM3le74EE0x9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=pyBnnJWM; arc=none smtp.client-ip=209.127.231.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="pyBnnJWM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1785916887; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=5nbgeTlwPmpvxBjsWXUMA4e+lDFnLr7P4RDG2gdlXMs=;
 b=pyBnnJWMoyhperjcxdEoaiV1DQEf+hfazApnmbDHpyTttz1lI6B5rWUp0WYmDiEXaXxmBq
 us34Rl/dGRNi3iI07+Zji0otErOGFYYD3jUJty4LEguzXMbLMfEwzjKDGiFBvsjs+msen/
 U041qEJjRDJOCpIbue10UGz9/ZRmIwLXuvG0xbKUjexUnCuAJTVRy9zkEDNh1plWCSl+Fw
 z83i6EDY092qXrzrYetZlLD6lN7so0+rSkudoXsO+kR9QEw3lHs1YGkj4bPeVZDMk5mqQW
 zVseLJJhU0JOgwROB7KLt+cr6VQz77/vHPWe/oMpz422wqBNWZPyRSqXL1Im6Q==
Subject: Re: [PATCH v2] HID: hid-oxp: fix UAF on pending work in remove()
Date: Wed, 5 Aug 2026 16:01:12 +0800
Content-Transfer-Encoding: 7bit
Cc: "Shengzhuo Wei" <me@cherr.cc>, "Jiri Kosina" <jikos@kernel.org>, 
	"Benjamin Tissoires" <bentiss@kernel.org>, 
	"Zhouwang Huang" <honjow311@gmail.com>, <linux-input@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
X-Original-From: Shengzhuo Wei <me@cherr.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804-oxp-fix-v2-1-b2d56e4c8a2c@cherr.cc> <anJGWjlmRxNMoVLG@pve> <CAFqHKT=AEy0-AZsUmcFGbo1iQ00J+ZMdY_9dNJp64wq1QSk6Gw@mail.gmail.com> <anK_oQqFpZLwCA-a@google.com>
In-Reply-To: <anK_oQqFpZLwCA-a@google.com>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, 
	"Derek John Clark" <derekjohn.clark@gmail.com>
Message-Id: <anLtyBB-Vq2D6REw@pve>
Content-Disposition: inline
Received: from pve ([111.40.58.243]) by smtp.feishu.cn with ESMTPS; Wed, 05 Aug 2026 16:01:16 +0800
X-Lms-Return-Path: <lba+26a72edce+f8d438+vger.kernel.org+me@cherr.cc>
From: "Shengzhuo Wei" <me@cherr.cc>
Content-Type: text/plain; charset=UTF-8

Hi Derek, Dmitry,

Derek wrote:
> Out of curiosity, do you have a device available to test as well? If
> so, which model do you have?

I don't have any OneXPlayer hardware. I found this bug by creating a
gen2 OXP device through /dev/uhid and tearing it down under KASAN in
QEMU, not on a real device, and I'm not deeply familiar with the HID
subsystem overall.

On disable_delayed_work_sync() I seem to be caught between your two
positions. Derek:

> I don't think the bug fix switching to disable_delayed_work_sync is
> worth the side effects without first addressing the global drvdata
> issue. That would introduce a true regression to fix a theoretical
> logic bug. I would rather you either switch to the devm_alloc drvdata
> first or hold that change until I'm able to do it later myself.

Dmitry:

> If there is possibility to have multiple instances then this driver is
> FUBAR in the current shape: one device instance fires up work items
> for another device. So holding the patch makes no sense IMO.

I'm not well placed to own the per-device drvdata refactor: I have no
hardware to validate the multi-interface behavior, and I don't have the
HID-subsystem familiarity to do that rework confidently. So I'd rather
not take that piece on.

Given that, what would you like me to do? The realistic contribution I
can stand behind is a minimal v3 that only fixes the use-after-free I
actually found and verified -- cancel_delayed_work() ->
cancel_delayed_work_sync() in oxp_hid_remove() (the v1 approach),
reverting v2's probe change and dropping disable_delayed_work_sync().
It's KASAN-verified, introduces no regression, and needs no hardware.
The re-arm hardening and the drvdata/attr-ordering rework would then be
Derek's, on real hardware with the hid-msi pattern.

If you'd rather I drop the patch entirely and leave the whole thing
(including the cancel_delayed_work_sync part) to Derek, that's fine
too. I'd like to land this fix if there's a version of it you'd accept
from me, but I defer to your judgment on scope -- I just didn't want to
silently walk away from a bug I reported.

Thanks,
Shengzhuo
