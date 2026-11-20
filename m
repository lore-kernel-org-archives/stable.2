Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795157868;
	b=T6+bpklfb4jaeAvjfEKEsfAEBar0PFwOQZJisoHM2OyDCusgm52JasXReo8WEhtUDAhh
	 ym/2Pkgl14DlGDAv0Pz8k/9d+TIMl2vZrYrAH6r96Ecp/srq0d6YfEOBAOKbMDfAfQ2Yp
	 VA6PyOFqiChx4gGEbAi2a/k0wz2sEfLOzvVWfM/IJWVRZlOtlQ7MOs0wtmw5c+XlSSg1d
	 guI7uTPJJ/RTL7x1ZIW3++dmyt9kBuEaTJyOBAYZSHLzrAFVmb2Z93p3R6Awjt+9zd1cp
	 Bm/FoD1767xefdgWXTyEtCM8Hlyz1ODX63UpGCfcBkEIt37IfktMplsldPW4OnupSEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795157868;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=MCFzwAdz6Pwr2Tc3TlblVGA5vcUZ6EAjb+fDF9tvqSw=;
	b=UTa/dMOa09zHfTeZZZYudsl4G1a0ct8GPaisEByFLtG7f5u/LYjRLIPv5qGlBVUVV4g1
	 0Y72k/vWzixrGX0aqzkGhoqxsWVb0p7nqAcH71kqSaGiy9vKvt/q2JDbs/aCyttxE4Pim
	 IhOwniTF0jK9tPGNnRL56ykb2KEutIziRI+R8WrP3BoT1AdGrntdW5Iow/3LN5XhZ7C1z
	 n3gNJpcXzyd6uX0XFdvLiu4Ft6sLS2bMBAUbcU36NFFDDP3dRpXGMLJApK60AuxxJdMBE
	 IjtTwclZJ2efqy6QmMuJN73OUakXiUaSrBWY+d8VDBqRxTJP7yA1LtDb8dZWqMap/tw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G91ObbCQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D537A606A320;
	Fri, 20 Nov 2026 06:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G91ObbCQ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795157868;
	b=cEHS1OBa9Ul+BGSC95L0xkXE5guuHTlkRaIQx8QzbnyWiKvqGIo/qNaAJaXpGAEMi6wd
	 MJg+Zdst1WwCGtoVq1dwRkOk6IbW65JG/5j6D6Jn+7amZn/BcCVlYDYWVXTpnvraajSMx
	 50CDSgMtXY9vbPfrzpGvGCiIYyTEM+mwNmMMoU9HaDbPMxpjG2Zlgug5mSRxSWmk0KxO+
	 5ZJ8irk7zt4bDya0Abs8j4ySF/6ZX0o0faQmvFGgt/cr1r2ZQyU2ehVpq6bXl05aJX5ME
	 vykIN7PIz2Lq0sMJA4OzQ4dVA+Vb2miW9SzXAWc9JMjZaG2ScL5I7Y/fN2gwd478bnQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795157868;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=MCFzwAdz6Pwr2Tc3TlblVGA5vcUZ6EAjb+fDF9tvqSw=;
	b=WqW7CqBCqYS9pZuhTE8ZeMZKkyF6pIUOhZx7SIHoN0z9lF24Fs7HRdXd+UTsO7FfXD2A
	 rBMGgHOgjYk/YDPMx2n2YYWiz5WyAB/KJn1IM2+xoNRAngtFxRTT4c03xqgP0zNdikQRE
	 ZQAQfm7H5vwkKVBOZC8IHH+XuqmANZIDU2bbzd0CqgSOXamEH/D0PHrLtYC+un999f5qb
	 DbvygGX7z8S73Mk3/ozvhat5m249Sl3NhfGsZ0fIlS0KedMIZKpedqfKxgcZR0pkR+RlS
	 odImvASoXcPk2WloEmbE2EhNj27rHNrXKQI8Zc13waIhaNT88RjJIYhBXA3/d/JqXUQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id BE74E1F000D0;
	Fri, 20 Nov 2026 06:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795157868;
	bh=MCFzwAdz6Pwr2Tc3TlblVGA5vcUZ6EAjb+fDF9tvqSw=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=G91ObbCQKPGUTDQ7zHjmn4d6ccKyuDeBAlH3LsSVIXdzulxIEIP/CdX91Wxqmuixv
	 HvuKEaTf4shI1QRvWdiLUgnbTkddf5eyEDHc23mSMkPROB77exeKHdUeFE3iV2y3Vd
	 7vvjZxO71P28rifzWevVf6FvvCAmjmWID34o2VNYIQvZrw05NCocALkedMCHKdVTVI
	 Tp7QGmuv2ufojF/oVkO7Qq6N30QHS+v9rG4zoQPPFMvWF7LcwwrX7mgnQgBtV7PIuJ
	 9aEBTgyexxKvchjhMAp3zfeKBNNUxzNKyE+GLZdW9tkZ8ZnfB+OqJXp5NnI2rImYgP
	 2GExyh1b+yswA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 40B2649716;
	Fri, 20 Nov 2026 06:57:47 +0000 (UTC)
From: Seonghyeon Lim via B4 Relay <devnull+forfortuna.naver.com@kernel.org>
Subject: [PATCH v2 0/2] can: virtio: fix NAPI stall and virtqueue use
 before DRIVER_OK
Date: Fri, 20 Nov 2026 15:56:02 +0900
Message-Id: <20261120-virtio-can-ready-v2-0-0defda2af8cb@naver.com>
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
X-B4-Tracking: v=1; b=H4sIAALv/2oC/32NwQrCMBBEf0X27EoSaime/A/pIU02dgUT2dRgK
 f1303p3bg9m3iyQSZgyXA4LCBXOnGIFczyAG228E7KvDEaZVtdgYZk4obMRhayfsTs7CiGo1nY
 N1NlLKPBnV976H+f38CA3bZ6tMXKeksz7Z9Fb74++aNSohsZ7ZZQNarhGW0hOLj2hX9f1C7bTZ
 8XCAAAA
X-Change-ID: 20261111-virtio-can-ready-85cefff06a84
To: Harald Mommer <harald.mommer@oss.qualcomm.com>, 
 Matias Ezequiel Vara Larsen <mvaralar@redhat.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>, 
 Francesco Valla <francesco@valla.it>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jason Wang <jasowangio@gmail.com>, 
 stable@vger.kernel.org, Seonghyeon Lim <forfortuna@naver.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795157866; l=1990;
 i=forfortuna@naver.com; s=20261110; h=from:subject:message-id;
 bh=7UHNUXHJc6SuRgb037ZK+F81kJ4BMtFKgcLw6ppT8Iw=;
 b=3Q0gUda1kTefGJ42u+omhUSG5N2sIBN/ExfcRfS/TewBnuFYwV25TljYIRqMwqwe22X7twi7U
 txOLek6KmiZD2QbBypeEgxrwEDsB7WNDUchgVqdSlbDJBPUd1ybvXL0
X-Developer-Key: i=forfortuna@naver.com; a=ed25519;
 pk=NSzj4ReyzmE01C4q/f+7jqXzWqsN5NwQK5UsSI6ufiE=
X-Endpoint-Received: by B4 Relay for forfortuna@naver.com/20261110 with
 auth_id=1481
X-Original-From: Seonghyeon Lim <forfortuna@naver.com>
Reply-To: forfortuna@naver.com

This series fixes two issues in the virtio CAN driver.

Patch 1 fixes an RX/TX stall when an interrupt arrives after the START
command but before NAPI is enabled in virtio_can_open().

Patch 2 calls virtio_device_ready() before the first virtqueue use in
probe and restore. Without it, resume hangs if the interface was up.

Patch 1 goes first: without patch 2, restore hangs waiting for the
START reply before it reaches that window, so patch 2 alone would
expose the stall.

The interrupt handlers could also use virtqueue_napi_schedule() like
virtio-net does. I left that for a follow-up cleanup.

Tested with QEMU 8.2 and vhost-device-can:
- With the interface up, suspend/resume (pm_test=devices) hangs
  without patch 2 and completes with the series.
- With a temporary delay before napi_enable() and continuous traffic,
  RX interrupts arrive while NAPI is disabled and napi_schedule_prep()
  fails. With patch 1, NAPI is scheduled right after napi_enable() and
  the RX poll runs without waiting for another interrupt.
  vhost-device-can keeps sending interrupts, which hides the stall
  without patch 1.
- RX traffic and repeated down/up work. No lockdep warnings.

---
Changes in v2:
- Add patch 1 for the NAPI stall reported by sashiko-bot. With patch 2
  the restore path can reach it (Michael's question about callbacks
  after virtio_device_ready()).
- Patch 2: describe the callbacks, add the hung task trace and
  Cc: stable.
- Link to v1: https://patch.msgid.link/20261111-virtio-can-ready-v1-1-0b4dd020af0b@naver.com

---
Seonghyeon Lim (2):
      can: virtio: fix RX/TX stall on interrupt before NAPI is enabled
      can: virtio: fix virtqueue use before DRIVER_OK

 drivers/net/can/virtio_can.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
change-id: 20261111-virtio-can-ready-85cefff06a84

Best regards,
--  
Seonghyeon Lim <forfortuna@naver.com>


