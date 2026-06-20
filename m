Received: from mail-06.mail-europe.com (mail-06.mail-europe.com [85.9.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2501A683E
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 06:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781937041; cv=none; b=pAbVbMqnfOaV/uNpzbnOwgGT+mcel/csFNJvRpDZ1UOvx7gEroG7K25NKOhIqa8P/4PEJSGor1olEVCWrKruDKkKAe4PRX4h7KzUj+ycAr91wMk+42S3ggv5D2Pr3Rb1AjElr6cPpLubx/c4S5HodPvVDZD1rgUm/GJkBjA8dEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781937041; c=relaxed/simple;
	bh=lhNi6gxuKrETGAYB5wjE3ei8Gfjvv95AAKzm5vG71FA=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=EaNG+u1nkOrk5a4IyGhrsTfRUHxxwtQL7uzQKvGzAUth+orgvIK6eg19br2xNmPdiG+AdofSMHY7T2c7msJzfN5mhk5nxECK8U1GSMmiWaSvRrOA8uoBgRU6TpdInV3nenIwifgHYZnPAy28fAThY+KfecDh/tX73AkfKxwN2wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=XTeltrEy; arc=none smtp.client-ip=85.9.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="XTeltrEy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=mkkebgvnmfe4la4nux266pqxeq.protonmail; t=1781937030; x=1782196230;
	bh=lhNi6gxuKrETGAYB5wjE3ei8Gfjvv95AAKzm5vG71FA=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=XTeltrEyt+N9tcBJhKqSTn+brG5yJl8uurMOg+1I/ZOreBCM7ZpO9aOc/cyeniERS
	 1cfitiLyvlCtgn7S0hWAMRlahG0UZWbesiaPwd31RFKAF/17/Tl42Y2HdGfP0p36FL
	 cbiwU/MFJFVzRjOv7V5kUU/xFJ7/1owZfH96GObDVmw9HwBP/ZhjISlJX5rZBigOhq
	 5aR2tPu6K146Tqakl7V23kZJfB6yeIdfUIwUZIpe16jxcHLetB/U5WxQFsv+3c27Lu
	 3Nkuahu7fiy/+wLOJH+N3nY9OgRmk+JOTvAecIRXnZC4qXfrvjY8EwMKAL/72mdJdl
	 tCVDOIn/EUCAg==
Date: Sat, 20 Jun 2026 06:30:28 +0000
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Cyber_black <Cyberblackk@proton.me>
Cc: "gabriel@krisman.be" <gabriel@krisman.be>, "axboe@kernel.dk" <axboe@kernel.dk>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: [BUG] io_uring: possible CQE32 overflow flush inconsistency in __io_cqring_overflow_flush()
Message-ID: <M9uVHmN1uFTdPdbQOITkChFjcJWO_U-BCOz4466zskh0n8rukyrE2nK4vlBcEQ8JBMyGZFPqBKCPyfZxYa0LdG5nkfxFBIcIOcSlAjrn1pU=@proton.me>
Feedback-ID: 117998405:user:proton
X-Pm-Message-ID: ac5d682972be787bdbc45cf1320ef4f250d087fd
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Thank you for your honest feedback. You are absolutely right that testing i=
s essential.

I was able to compile the kernel without issues, but I cannot test it prope=
rly at the moment due to lack of a suitable test environment (no KVM/QEMU s=
etup, limited hardware resources, and financial constraints).

If this means the report is considered invalid or cannot be accepted in its=
 current form, please let me know clearly. I will revisit this when I have =
the appropriate infrastructure and resources to test it properly.

I don't want to waste maintainers' time with untested patches. Thank you fo=
r your understanding.

Best regards,
Eneshan Erdogan Karaca
