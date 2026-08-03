Received: from va-2-60.ptr.blmpb.com (va-2-60.ptr.blmpb.com [209.127.231.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B013C343A
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 23:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.60
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785801313; cv=none; b=P3Hdnk/6TizeskQ1LkgQaWfpKVQVhWsBO/0oYx5p527e8xEmyJDnV2EcpGz5zhoes0iL0nVQ2AvawH7cxlVHz/WembM6AHPhPxTJgjn29ro6UPXP+PnTfljyZf0Sm4WnJFOSegLBvQhkBWapwYa+y10MLy00wKf6tPIwdgox8YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785801313; c=relaxed/simple;
	bh=rfOy4ijqLRjq51iAooUviNWJz0Pp+uy/0o0AjyPa2Vo=;
	h=Cc:From:Mime-Version:References:To:Subject:Date:Message-Id:
	 Content-Disposition:Content-Type:In-Reply-To; b=gki8TXU7iQcZjHjyIzT36q9qoj/djdNZpXpjF4lNBScW6tXr7EqvetA2xVYaf0PSeg/GH+A+9AUX5esAJZ6ES+y50v6odhMGPSjgMIVCrtZOq9qL3L9ZJuo+/t82LYLT1IP/VWlNCxDayxzHUwlSVPYbbrczZFJqSs0r6qC6Sts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=VxJcjkJN; arc=none smtp.client-ip=209.127.231.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="VxJcjkJN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1785801302; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=rfOy4ijqLRjq51iAooUviNWJz0Pp+uy/0o0AjyPa2Vo=;
 b=VxJcjkJNx0V0GKZEFpKA1cCpP5KrigQLBc3olQm5/HcgMLr9yz+raGwI+t31T5Yb+Dz8QA
 IA+WjBxSbJYnsa7IcOe31f95Y7Uz7LWpyCfg78of+k6XkAdR0UlLM1A7B1pMsKDXXcYGql
 CyFsF4g1OCt1oylvADJYuFpjYcvYGN38EOrORQEuhsUGkVhHIG3vXAMDpZ8812ehejW5l3
 maILytQa/8RVxgatfwgdatIlMnEdolcZAQqCzX5U3pFWU10jI9DiCtBOQahj0sjwxElOJq
 e8SH3zLo8FjQM/2kTfzn18Jab7F1vjZwYVe8D5x0bYrexkhfu2ynrOLX+sNcVA==
Cc: "Shengzhuo Wei" <me@cherr.cc>, 
	"Derek J. Clark" <derekjohn.clark@gmail.com>, 
	"Jiri Kosina" <jikos@kernel.org>, 
	"Benjamin Tissoires" <bentiss@kernel.org>, 
	"Zhouwang Huang" <honjow311@gmail.com>, <linux-input@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
From: "Shengzhuo Wei" <me@cherr.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Shengzhuo Wei <me@cherr.cc>
References: <20260804-oxp-fix-v1-1-51a4fe787167@cherr.cc> <anElA4get_VxNuB4@google.com>
Content-Transfer-Encoding: quoted-printable
X-Lms-Return-Path: <lba+26a712a54+87fdaf+vger.kernel.org+me@cherr.cc>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] HID: hid-oxp: fix UAF on pending work in remove()
Received: from pve ([111.42.148.29]) by smtp.feishu.cn with ESMTPS; Tue, 04 Aug 2026 07:54:59 +0800
Date: Tue, 4 Aug 2026 07:54:57 +0800
Message-Id: <anEqUZyJGBrQ6HIW@pve>
Content-Disposition: inline
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <anElA4get_VxNuB4@google.com>

On 2026-08-03 16:33, Dmitry Torokhov wrote:
=20
> What stops these jobs from re-arming? Should it use
> disable_delayed_work_sync() instead?

Agreed =E2=80=94 cancel_delayed_work_sync() only drains the running instanc=
e; it
doesn't stop the works from being re-queued from the raw_event / sysfs /
LED-brightness paths before the device is fully torn down, so the UAF
window isn't closed. I'll switch all three calls to
disable_delayed_work_sync() in v2.

Do you have any other comments you'd like addressed in v2?

Thanks,
Shengzhuo
