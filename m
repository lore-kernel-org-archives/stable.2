Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794093680;
	b=iZYcBisCTYBxJLMVTrqVjdN+1j9IDJrBd1x0SZcSHJWWUNwjfdjLON8nTnA7MwHb485m
	 YyL/kVPJ2PXHo+LHM20lyTsjcCQyVeGrXYHYd4TBXPNiQIaEQR6sYQPu5MruT1wrzCXGV
	 RJ4Jur1bDgqVOr0/0THzxG6vJZsvQFrDuXbB/NHbalYHrbA2Kthf/++EHhngH4L5NHf3v
	 npHONh7MUwvYsdCCB/s4uUMng3RmAhr3jTVZmTyPRLieAroJBh/LDM+KnG72AHSsSIKXq
	 8og23vQM+LpsPPoPHWpxVH74J1AnfKoC1vFPb+SQVDqpxP+RWKZ3WqRYjJPVOucanlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794093680;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=07Kn/A0dbPa5XNw0xRGiconjy2NYHS9IZKp31N2JyPw=;
	b=oldkA4LhwHJhWMtmakE91bY2X4HsrhkztdQyeflEE6HnLzc4xZXrBCiyRMg+XYRDuB7f
	 iVrKSR+SXiguDgZXJEvAQGbiVCSRCJcDcy2b86PFuBzWnE7WoPpevibHtlP1+drKRI+7L
	 kuuiAYwVEd3cl12oi3smmfTvLZAuGDkimOk9uSRJxH3rqOsKRk+0yAu24gp7EOwyyo5RF
	 NwKPMtY/243Wm+7hct62XX8sUCp+mqNyyFe9yPCK4tdR9b++23ttpPatTJyeKE7IXSQKv
	 yn6TVMyw0/pvMFXTB44k6syoXbLtPtsJ3aesS6IN+5qTJSIRa/BlQ98KBHyxqjVK43w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=eL6sG8R3;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="jD9a7/UK";
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA05606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 23:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFA05606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=eL6sG8R3;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=jD9a7/UK
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 318281D00113
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 18:21:19 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sat, 07 Nov 2026 18:21:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794093679; x=
	1794180079; bh=07Kn/A0dbPa5XNw0xRGiconjy2NYHS9IZKp31N2JyPw=; b=e
	L6sG8R3g+TUPqtjKzXYyDsW16kxhco6MWR6Wyh8svZ8Tqfyq9zalqXpMhhPzsRhq
	gn5MW+WU+YIn0bNxOZtM8AJL6vo38S7TXDtxIDDC1v5L5z125ImNDwZuR5VgK2op
	RbbauHXceM0C386mzHZn36bRs9cdzx3JR4IV6P7SisuUs44KYlbaCfL3zoYB8u3s
	bhc8QEAIvNIU60lNi5cdU1JLxilaRmcN4bHKP8WBCqhBXZN+QLclXBPrAYeaj2lr
	2V1M4e5Efts0MAjH9Tk9yhmEF3x4ghWCbrVU8fIOMAXl0ymWLktD6jwVoM/0VYbk
	8XFzZjqABJa4d4rfWq9FA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1794093679; x=1794180079; bh=07Kn/A0dbPa5XNw0xRGiconjy2NY
	HS9IZKp31N2JyPw=; b=jD9a7/UKWo70zyblBLkJFa37O7c0O5aKf+HZgOxIYRBv
	53FZQ9SRj1rO9UaK8gCqjYYubK+GtZ2kwAIDg0B03l0qFCz59ot7fVjiotD8ag7F
	mZjCDS5XXvEHmvaDtYZnxYj+pXpcVtKSau/YGXnHpKOOn7hqGb+9AjB14delsVGO
	xPkzGVQs7SBxE4FmPpgDjrvi5cA/cg6Ksjxh+z2qdztwI03qXUUBJ8cXfy0HyUaX
	yN5fF8E7CBsM0ToIRCL1K2TMaMCfAWZUp2/e6YkXxv5G4hXfE1ziD10DAYJmUkaP
	Kb9PQuq4BtAD5tnO6H0c1YPWejIyAMQ/527/38sCZw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794093679; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Zfj10Osj9rs1FeDgh7krrj1qmUTcs4qUzyn8ii8J/DLMxR/
	KoGRrinBxXY2h3a1cEjjuq8QwE/ePFnbd0skWkOIKNrvHgsNmxfPUb7l2i68JRul
	/KJGXyILz3v8daca0E7L7zshPoJtDksE675TfrOzK/kmWIO+KAGUcdxrGb92GV1V
	S3DPKa+Wwu6Fp4yCqaiKnsptOQGdf2Sy1tbU/wJar63pS6fmUCnX5cBEKbzORSl1
	oCB8/o/8cGFJHyMJiaLH07LLjwsf+t5IWd7g+fB3euPMf9uemWd2XnQoi+6z1moP
	nU75V1BOjWbU8Iihip9vusmrdAytEo884cFjyzA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:823zdyk9vQ/LO/9+ky/lfVcDFSeBxdviv75aGC3IPqA=:m2MzJRD9sfsfavqV3tC6Cw8kd+sYi3YwPX75/MsqcNk=;
X-ME-Sender: <xms:brLvarZp0Z_PqSS02LJv1odW-TtaFK9i93hkNGTII7qj5yNrA9JLcw>
    <xme:brLvahWbix_ooWQaWhYSRlJmyNhrrsRMYF_XCQpSNeYkZKZk0atEF8jmWzadb2zWz
    CCtfEewsFpuGmo5cMAm-1fsgDP0pAqFIeGptqA6eIYyKFHYN5VpJtf_>
X-ME-Received: <xmr:brLvajlRRIWF2EhvcbHVfQGZPt6Z_GSKvctuF5TAdHi_H6Uraz-a189vvN8B9bVhjM4N61E>
X-ME-Proxy-Cause: dmFkZTFNo1YXKUXylI30TwSCqEQg1wRXRNxcHJ7VTwdPv4i+HQSBUDIu7rDyrEsx/fsVPS
    mGFfTdMbfrlE1vl3SqSNDq8FVgNzp09Ly69nL+muD9FUcl7o8gWlw2guLmEYh4MFlUZ+1b
    QbZovnJWcIicwaB0Wj3SJKDfJTg/XCU3I2NqQFxG2GA/8Dh3uiykaPEBTaar3Knty3rHuZ
    xZ38zZ5AkR6/PonYLP8diGdZJlx1J/0EPmS6dY+MaeGLNUHrdfVnRFZfCFExr7swQ9GYNp
    FwGkZibdcog4tyZULhyjqOw4WB7iX1v5/j6dGgqcIt5f1y35xT1zZpQWXJhIu+WEGAWJPM
    pKuV4abaCn0i/i/EhmiOcZ/vLLEQ/bJgdLxohFUblbDcaZF/opBokQEKPKKAA9IDUdHICH
    tBdLmXYsJhUrBW1RcoqREFsmujsKDVz1XncXy4n/OQss5WtU6rkkuI5AmdG2AO+Wb6QX34
    iCRmVtJEJwyXyLlpHNumlbTN/Uk9269WrQd9XKNWYyWmk2UhP6a8TAEYhD4TvBnf2Z/wcC
    5uBisjynx8cDUBg+jOvxwtEsvlctkJ73pUv4XHt8HALkbcFJDtj8JjYfgVXjj0qY46PsxP
    K4R1iHwFAtllPf/z/EU+hs3EkptVnFpFpLZ4DNdM4Q+QbWvM2pwxC3WcMj8g
X-ME-Proxy: <xmx:brLvamxMEdaPoqcI_tJodw3OiMUHYfSqjOrIU10Uq4x7_QqU79Q3yQ>
    <xmx:brLvamiHu2wGIAZklTtV4l270GcdknwLMLf1X6lwOp_MZYIMv0dK_g>
    <xmx:brLvajUEC41nmDGaDzQNUQW56-3n8JORkpQ7ZbSDVWqGj-bDeaMXhg>
    <xmx:brLvag1yU9kV-KlHYZ9FXUrf0qW0nuv6lgxlovajaKrVuwxFn-4I3g>
    <xmx:b7Lvat6O4f93GB9EABE4DUfRZGpnid82J0-qw1wRl7ZsqRJgdgTvhUXQ>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <stable@vger.kernel.org>; Sat, 7 Nov 2026 18:21:18 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y 0/3] Bluetooth: L2CAP: signalling response fixes
Date: Sat,  7 Nov 2026 18:20:52 -0500
Message-ID: <20261107232108.1873786-1-oss@fourdim.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107054925-failed-6.1-6320736af7dc@kernel.org>
References: <20261107054925-failed-6.1-6320736af7dc@kernel.org>
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

Backports of

  6320736af7dc ("Bluetooth: L2CAP: Reject signalling responses in invalid states")
  a518b9a9ef6e ("Bluetooth: L2CAP: Only accept connection responses to outstanding requests")

which failed to apply to the 6.1-stable tree:

  https://lore.kernel.org/stable/20261107054925-failed-6.1-6320736af7dc@kernel.org/
  https://lore.kernel.org/stable/20261107054922-failed-6.1-a518b9a9ef6e@kernel.org/

Patch 3 is a9f9eeb5344f ("Bluetooth: L2CAP: Ignore connection responses
with wrong ident"), which tightens the check added by patch 2 and only
applies on top of it.

The series goes on top of the three L2CAP patches already queued for
6.1.y:

  c1398cf11b31 ("Bluetooth: L2CAP: Reject mode changes on connected channels")
  c5ebb0245fe9 ("Bluetooth: L2CAP: Reject invalid TxWindow in configuration requests")
  226fa3b676cb ("Bluetooth: L2CAP: Use default TxWindow for zero socket option")


Jinwang Li (1):
  Bluetooth: L2CAP: Ignore connection responses with wrong ident

Siwei Zhang (2):
  Bluetooth: L2CAP: Reject signalling responses in invalid states
  Bluetooth: L2CAP: Only accept connection responses to outstanding
    requests

 net/bluetooth/l2cap_core.c | 47 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

-- 
2.56.0

