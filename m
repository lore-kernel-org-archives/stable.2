Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794093416;
	b=CwOZt8gVJ1JCOeT+zD+67M8UeaXle+Oq0pcJbctLIGtRGO33eCiWtQRmjmKSuPDrbUfA
	 KRIyX7U/F4fM7/9b8qvuEn0QW2nJ/No0mvdrC5CRfw0TOSnKOAOT+tG2shHmeVfPCvqZ6
	 0RtjRQSNsfv2F3wRmty9QF3t04dN4AqLH33vXzU5MUdpctk4zllfqyTbTDXtE7CZOtCZk
	 d8f1MEQP5eoQ2E+xDDSJkI5N3mbL0onq3RkZspp3eElfiXZ0JzgQ24rbXuBwYIOrooatA
	 i4lX4XTOrx70JlTemX/kLM70sJv/4XMOC+dBgiHZwJiFOlnauSErfA3ieX6Si1MGW9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794093416;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding;
	bh=ZTajiCX7tzf6J9KvWH1GO+z2LNqCqvg/iBETMigtOXE=;
	b=LNznHPCq8LGTcxytm4A/qEYrgL2FmWZxlWJzNtZpVJwNicu1PvatShsb3fddwcEg6+8y
	 oUGdC6cRYrbkD7rYFverSoivSBPIm5tU/QvCZh0u741nO9iX4Ap29a+aArgu7XOwEPhbF
	 jQ5KGNGNTxkJaOjo1W2Z/XPPegXvtcE8pza1Usbm0geFoWm/KJQ3vVyKZoONabPJWt7rF
	 AQK7zs+pFoIfcvjTtbbr0rH4/MNZyRXJoN71OmXhiUGGLNBxRJGWxhy7cljiN+nfobIeB
	 p0P4MPHu0a+tcJMgYeoGfiIIvV9JTpO+Hu1+6TuEtPWS+2+mQ5bqqaywbPBq94Z9jog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fourdim.xyz;
	spf=pass smtp.mailfrom=fourdim.xyz;
	dkim=pass header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=aHOJyKwq;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=437l+AQ4;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6CC606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 23:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C6CC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fourdim.xyz header.i=@fourdim.xyz header.a=rsa-sha256 header.s=fm2 header.b=aHOJyKwq;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=437l+AQ4
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 799C81D00134
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 18:16:55 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sat, 07 Nov 2026 18:16:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1794093415; x=
	1794179815; bh=ZTajiCX7tzf6J9KvWH1GO+z2LNqCqvg/iBETMigtOXE=; b=a
	HOJyKwqRNxLszwkhS1W3I/URqqNhb2jeXSFJg/XoUyWHreM+n+LsaWqNhuiMoL//
	5z4uErA8XokYfjfXhnzrwxbe9/KaXaEgTC72AjgxqXXRidf5lJEmLaattHByvO+M
	m8jtQmXM3mQ5E4rLAge5RkCuLz+G+HxrjoV1uovhCQm99FH1X0OcXoX1GxPcxunx
	n+KDMpmxDfUNuWhd5RSI7HZ2tiqcQPquhASwN0GsCSGHTjitvVUjg3eVtCswUJk+
	o8wFfOCuRbRaii/k5uef2d3b4zNznItAe9upP5nO3eWIqtCf9lPqCRd7g0bOdUkB
	8i9FMqYMR70LbhbtjlnFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1794093415; x=1794179815; bh=ZTajiCX7tzf6J9KvWH1GO+z2LNqC
	qvg/iBETMigtOXE=; b=437l+AQ424kOH+YnpemByZI/IkDj3wLow8qJOZkTihu2
	ng40zSb4AGtIRVJIgrGGxEACkuV480YnP3CR5c6gwqnECd87IauJ5ObnfjpVDnQe
	xHdRhtgUOgXv6LVjRgJ7DBC/BL5HMLCDOq5hyAw0Ty7GJoVHh0tTnHlfZKnewRrG
	KaKwrDgG0goOdqxm/aOTv3OaNzgTcaORZBH4uIHLNYIrYkhIvn6emsS2faO+uZfd
	+vyFSu7IxxCjeFuZEYZORQn8QwWPipkwXeTGvIZloGQMoqtTtCMN6wJ2pGNnki63
	5sfllT+cxaZOIjFeVRiJPs2wXbcfa9HJqpmjdfSIww==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=fourdim.xyz a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794093415; d=fourdim.xyz;
	mf=PG9zc0Bmb3VyZGltLnh5ej4=;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:kvy5o5zov9PfwMl260Q7gGpj6sJc6mn5nCkSuLbWwwYOLed
	jgqcC/rgV7ngvlVPEAXV1WCEtmcMh8BOxV3j8xTnjUut8lq3uyH7+flf6i4ABvfR
	2aSXwGJouAT/E9Cfu8TaBjg7J8+KY5D5YkRg/Ndq0WaEx8QL+znqLGiYzXeU72um
	Yl9M9OaJ/dpjDSLgl1lsV7Taoceftk5kWCy0PXHd/mhfl3gCcwT0zJwAJeIZxUk9
	lgQORaBCPdSZFJwmrnbcGhBhF/pSPPA1W/Dw8fScxTzPwDm37tSR75yYyZNpXpeS
	M7Fwor/guPC4GYRlk8JIfLZwkTwaBxAFmdj//bw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=content-transfer-encoding,date,feedback-id,from,in-reply-to,
	message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:YVeojczC/b9l4DNomG8UGK/FOdTueLb7G1budqYTayA=:iaNiWqZ32Ly+O/KXCGLC42rnOEWMdNDvwbE8WnUdvqg=;
X-ME-Sender: <xms:Z7HvajALlm2vF_G7er-9_MpO325TQntSljXRqUii7EcpwGoyNS36GA>
    <xme:Z7Hvagf4zw1Flj3gT4vMAl9ir3coelua0LXnvWvEHApSWn3B9CRLho45eGeFPZh1P
    E2OkSrBxkyop2to6Nm3VTBgzJnf8h5jvHMi8DapKaY7T_R5hC7VtPcI>
X-ME-Received: <xmr:Z7HvakNQ-e7vQ8AbOqWB8uaPttLfvuhxMI1qgjcahdlAz5ENfJvtUo4HKkReRhORHAnnNZg>
X-ME-Proxy-Cause: dmFkZTFAFlDOvFwFUeAmNt0h0VqaTvV6TfMYwUU9FIzaVcnVOYbqdI1eimRdqxtvED64gI
    lEB+HweWXG1aCxz3xxaPJjHdKp6SXazJ9B3Jf/VpshJsi7GsfCwlarIK8CHnerjMJvIL4k
    O5Gz3IwLkEGO/mHiT0+10Pspgi4ay8DCJyj+rUktftbCK+zdqx/7t0WJD4nf0Vse/zEygf
    ZaBrfmhT8rTjh+f/HZX3l04oZro7HXU6KfLUcIBYR7r64s6bP1q68oi0XMfM2FhSJKQH5D
    ikz/BqR4dRVskz9ViQFNx07fOy4g9IuZh02tJGcWjUOXKD7m++ZSCtP7bMlFPf0FzpOKhF
    m1VI6aqdNSp6wXq3Dk5S1YwS1dXD1pr64nf248aL5+dofJZWvKHc+9RAHhGiwkvQgGSN9l
    wkrANZeKgrVuy0oM+4R6viNcqkBn/irU3+fEQ9UIdP1fqrUUHc0+u31j899vMtMiYoNFMr
    t/EcKnn6MYI/aXmhVPPSoLrfmgtUZek41MhHmAn5Om7vMN6jIDBStn/wZrPpDuJbeheuod
    BdGUeKtvmKgQNXYXZiPIju1norRb4kdJ57iNfuB3UBrHsb74I/muykq2j6tsT+tyqfoPvA
    lGHo4crzSR9ggAqlAbVNJRAiVAaaG+VmtgTiBAnmfpS77PJn0MHOwbApPgVA
X-ME-Proxy: <xmx:Z7Hvaq7ffD47TiTJj8yrhU189RavopVRZVUrRoeESCAv22zKGZYZoA>
    <xmx:Z7HvaoKGroUWChdhTThn4VWDFLpln8uggLbJFAQEFxgd4SHTxIp2wA>
    <xmx:Z7Hvakf-qjXd9KWVxzu7CmnsrPOkn0YsYQDUBeSrbBK5T6W9rGzDwQ>
    <xmx:Z7HvarcXtYRpa6WmB6wEkkKE4VEki0Xp2-RMIZElnO-iSG3GR5NKBQ>
    <xmx:Z7HvaqB2QNTYXdbTHCPJTdJ1I6FOiU38KCaSNEVZsUUI2RtRPh8StG38>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <stable@vger.kernel.org>; Sat, 7 Nov 2026 18:16:55 -0500 (EST)
From: Siwei Zhang <oss@fourdim.xyz>
To: stable@vger.kernel.org
Subject: [PATCH 7.3.y 0/3] Bluetooth: L2CAP: signalling response fixes
Date: Sat,  7 Nov 2026 18:15:44 -0500
Message-ID: <20261107231558.1868970-1-oss@fourdim.xyz>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107050447-failed-7.3-6320736af7dc@kernel.org>
References: <20261107050447-failed-7.3-6320736af7dc@kernel.org>
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

which failed to apply to the 7.3-stable tree:

  https://lore.kernel.org/stable/20261107050447-failed-7.3-6320736af7dc@kernel.org/
  https://lore.kernel.org/stable/20261107050449-failed-7.3-a518b9a9ef6e@kernel.org/

Patch 3 is a9f9eeb5344f ("Bluetooth: L2CAP: Ignore connection responses
with wrong ident"), which tightens the check added by patch 2 and only
applies on top of it.

The series goes on top of the three L2CAP patches already queued for
7.3.y:

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

