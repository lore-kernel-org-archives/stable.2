Received: from mail.w13.tutanota.de (mail.w13.tutanota.de [185.205.69.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E273B1018
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 18:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.205.69.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785261802; cv=none; b=Aos4T9IPQ00NlkWmYE27hGgteEhyG+UEIREWJPOmy8OzoZ5YqlaXgoJKYloZF+X9DggEwle4wcwLOn0CAx1B58+CjdCFIxqz24+hVk0Z2Vnyq4GlFjURuIRD5GNbiTecPsMzmrxUKFtFjoW/SY1/h18H2lutGFmrHBvHVRTBEIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785261802; c=relaxed/simple;
	bh=WJ1pCaQQrTM1bEP2bcnu7L+EZh5V636z4MFZubTS/4s=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=OETEaieoPb8n4rvGdnkU5VtKUYSK4gxJh+pl7onlkWvk2AOe9QXGsJxOvBSf+o/Rcy/2UNVO4hcbAq5Q0VdwimOYLUTalyaA4BsEhVqjUL4nU5NixPu8OoxdSW/ow50KDu1Nox+VjUNL5Ay1mfBXen+6paL3G60yB7JIl40riN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tutamail.com; spf=pass smtp.mailfrom=tutamail.com; dkim=pass (2048-bit key) header.d=tutamail.com header.i=@tutamail.com header.b=C2Rmft81; arc=none smtp.client-ip=185.205.69.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tutamail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tutamail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tutamail.com header.i=@tutamail.com header.b="C2Rmft81"
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
	by mail.w13.tutanota.de (Postfix) with ESMTP id 6363C165953D1
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 19:58:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785261481;
	s=s1; d=tutamail.com;
	h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
	bh=WJ1pCaQQrTM1bEP2bcnu7L+EZh5V636z4MFZubTS/4s=;
	b=C2Rmft81JHodulsqObHSMX5RjmVWMAgfYk90hOiypYk5KDDdgiHOpuPz0S/UOT7Z
	I9aNX4TZxNzNLnR6fer52dVCOpChEcfBjOH5OO+4YqU1H0hRem/TcaUIiarBdeUTY0J
	mW2bOM7xTz7F5qAe97NeVLPXXiXWbxW1VuaIivLZzNg8jVX2ACrG5QlLjLJBH5q+xIa
	2vLJkaOtTaHIGy4gbH7a6XRefAT809y3PuKzkKYnWudHwn1PKVUl5yIBBqu3YQAEd/U
	AMEkXtnSfBSns63rBob6QVzsqW6fNaW4ANATJ4hfNfjt85t8B6iifhstB60i04HwCs4
	/FGm2RCC7w==
Date: Tue, 28 Jul 2026 19:58:01 +0200 (CEST)
From: cybersnow_2001@tutamail.com
To: Stable <stable@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
	Ojeda <ojeda@kernel.org>, Broonie <broonie@kernel.org>,
	Tglx <tglx@kernel.org>
Message-ID: <Oyds0Xu--F-9@tutamail.com>
Subject: Kernel 7.1.3 - Unable to fully shut down
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Feedback-ID: 0148cefbf77245a42b8d92790169c2e5f3889e2ac922109814e9377b88997be23fd058959082c4e525ef1b19740c34b7ef4478cd506e389835ad86d84f5ca78a4f:TurnOnPrivacy!:tutamail

Kernel 7.1.x introduced a new bug which make computer unable to completely =
shutdown the computer. The Fan continue to run and USB ports too but the re=
st is down (disk unmounted, no screen). I need to push the power button for=
 10sec to shut it down.

I have an old laptop IBM Lenovo T61P (from 2007) that does the same problem=
. My laptop is not an AMD CPU. It is an Intel Core 2 Duo 7700 with an old N=
Vidia card 8800GT or something like that.

Reference:=C2=A0https://github.com/CachyOS/linux-cachyos/issues/900
