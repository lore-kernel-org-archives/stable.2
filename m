Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794282990;
	b=Q16yZyaPAEKP/1kQNiFRHYA3OcCqJJ5nQ6rSa/uWkVojT4lK1o4fh2sw+rwy5M1XYU+R
	 bC5lfaWY77BLA7KHmBN0IAz/K36i1JhgoWI034RacR1zGMstBlx0cUcnMqXX6aIMIJbRz
	 PlzEQVH+VQ6c2RNSubuk6Nj1yFScaVj2s+QZquVLHTnFNs2XzGvJcGDxZ08pNH6y9p68E
	 Nvy8qA0w4Z9FnO3fL/Rgy/hRkdLbPhj6hvly8QNzNIx8sIDfS6YvSKmRZTVKiGV1ZJBdi
	 iK8Ze2aYhILblHwC4RyCeLgK8quEe/iT2MejaID0y57HOu/g6pPvMPQ+QAkvhR5SdNg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794282990;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=HKijrm4iFxv0lGr5+TRTQ3vfM4oyEPdmlY0fk3stieo=;
	b=RcTn3/CUVna8V8jNhp+Ox0QWAqotz71YVfklULCRyJpqidsoujP8nJCJ5N6MJQ/cBg6j
	 uMQjKYLWH4ifXHFnvv53F0RJ4w44xr8EfP3Xf7XMWi+sN50f6Vg3YY05+1eSZVOrSAgUW
	 851JWbgXXRhsCpsyqhh2HrX42J5GSPoKYSbfGpUuNpgN1gHQNkpzZwJMZMj198KQP72w7
	 0qhda+dd8PNHYlFaI80vcVaFWNHzT4exfIda3eLEJxaNY1EBgva/mkgqkuJmouuVagf7Y
	 0UGwVjEQsmZ3vtBeXwLj+bNsTSoUvo+vDniaI3vzgbx7338hhSPB00Vnp2CN8vf2WFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jOxfE5EK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C5E606A330;
	Tue, 10 Nov 2026 03:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jOxfE5EK
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794282989;
	b=IKdzctWWbs6xNMngL9Wf3zgQ5u8lH/w44HbHzW3BCrBsbuhXiM5C5+dLfnjmjMvPNm53
	 AsBw3LhZgqwf4JP+wfjPQ+QkuNlzME09tCQ3V7GJD0Gck5GjGYavcke845CBccjjCwAJA
	 bFkukdI8XEDmuyIOlJJb3aLj8eNr9BDh9l8IgMcqLaw2VMILzWDTwKsD0C4VY4wTFA5Eq
	 jwIGvjfQx9zZUANLGu76HjX5pxYoJzNbY6KajRTsEhoEKXEJuGJdrP7Omh/ZeRxrlHZRB
	 PlFE9v1Os9pGtTvUDCpb462EbIm7iihZiH4qs0Jhz0h+S8srDdACoEypLpRUFPXpqEg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794282989;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=HKijrm4iFxv0lGr5+TRTQ3vfM4oyEPdmlY0fk3stieo=;
	b=vpykQM1P4U6POx7/rhaJ5aQnoX41Zd4i7P6z864OJfe5JiA3A8ktj3tBT1ApQjc84rbq
	 sFwZkmGE3E7lfmi2mO0eI44lEL1WsEf6f0iDbDE9xNZT6OTXGqD02lzAhWy+ZebPnt+qR
	 IkcQOdyZef2HXkPx02cdm5DjZeAl7WZG50yDkJ6dlhHJjprinFpEW9Ph4iO4hQS/zVy21
	 0aaOnTdciHGOhEuDeyRuqvwggV03lubjDktnZho/E5m5cu78lkl9KEHzs5xI4nz125qub
	 V+zRcyE2Ma6ALn/y8XiZ+9fXJkIHam+eoKdLnUfFiwznT4TVFCS740fSSp7BAtzw+sw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BBBE81F0089F;
	Tue, 10 Nov 2026 03:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794282989;
	bh=HKijrm4iFxv0lGr5+TRTQ3vfM4oyEPdmlY0fk3stieo=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=jOxfE5EKwTHeW7dc43lRGNsWYloNduS30LcjgjMQzNRTcfry555UUpcXymCmv7cLw
	 CNtY6e1WpIQywCa+6cpjYdIOW8H3q4xi9b/cQE6ZWEWBXag5aIOKgctJMxCFkBop50
	 TRtCqcKDOEk+Q+M8Q2EMbWcX3QcMpCS0IeJu64tl++76LAKQbGDZ75u2hj+3Y759wn
	 c8oVq1RoSLIZES5PmjcGMo3XnNcJIZCfI0a6ctPNgE8gOqd3so5EA++gSvUl+VwCNh
	 gQY9XOsDKlYALMHG39kCN/pCTuQzZ5isWbZCcESG1fp8qigzX226Of1X6qmbvECkVJ
	 pF/Mx8HDz5TmQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 47002487DE;
	Tue, 10 Nov 2026 03:56:28 +0000 (UTC)
From: Joas Antonio dos Santos via B4 Relay <devnull+joasantonio108.gmail.com@kernel.org>
Subject: [PATCH 0/2] can: esd_usb: validate data received from the device
Date: Tue, 10 Nov 2026 03:56:27 +0000
Message-Id: <20261110-esd-usb-validate-v1-0-7ee499b4926d@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOuV8moC/x3MMQqAMAxA0atIZgNNqYJeRRxaGzUgKo2KIN7d4
 viG/x9QTsIKbfFA4ktUtjWDygKG2a8To8RssMbWRGSQNeKpAS+/SPQHIzlbu9AYrkKAnO2JR7n
 /Zde/7wfkG2JqYgAAAA==
To: mkl@pengutronix.de, mailhol@kernel.org, frank.jungclaus@esd.eu, 
 socketcan@esd.eu, joasantonio108@gmail.com
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794282987; l=1242;
 i=joasantonio108@gmail.com; s=20261031; h=from:subject:message-id;
 bh=NrnaLsUdLYntN7kCE3mY47RXA863esuDVw8vT5S2pSI=;
 b=l5YWgTSBNmD5y5+OG7ciWxSr/DGlFJJO4JiGeGn0JyeVpi1AhNsSvNO57ZSpK5QajBm2IWBRf
 fIdDy92OrWsABLFuxxVK9rcsj5bax3v4kHfwn0WXsqEnCfP/smls3Go
X-Developer-Key: i=joasantonio108@gmail.com; a=ed25519;
 pk=ZxAznJT/FcPPdzLrDDFJQm4LLjjHVGBBqDSG3TXS23w=
X-Endpoint-Received: by B4 Relay for joasantonio108@gmail.com/20261031 with
 auth_id=1371
X-Original-From: Joas Antonio dos Santos <joasantonio108@gmail.com>
Reply-To: joasantonio108@gmail.com

Two fixes for values that esd_usb takes from the USB device without
checking them.

Patch 1 limits the number of nets reported in the version reply to
ESD_USB_MAX_NETS.  Marc Kleine-Budde asked for this clamp during the
review of the esd_usb cleanup series in August 2025; as far as I can
tell it never landed.

Patch 2 validates the message length in the rx path, so that a zero
length cannot stall the URB completion handler and a message is not
handled before checking that it fits in the received data.

These issues were found with the help of an LLM-based code review tool
(Claude).  I checked the code paths by hand against v7.4-rc3 and
reviewed the fixes myself.  They are build-tested only (W=1, arm64); I
do not have the hardware to test them at runtime.

---
Joas Antonio dos Santos (2):
      can: esd_usb: limit the number of nets reported by the device
      can: esd_usb: validate the message length in the rx path

 drivers/net/can/usb/esd_usb.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)
---
base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
change-id: 20261110-esd-usb-validate-14264b90e5bb

Best regards,
-- 
Joas Antonio dos Santos <joasantonio108@gmail.com>


