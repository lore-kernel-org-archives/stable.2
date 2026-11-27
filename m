Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795812837;
	b=JEff+GukMLmX24FdK1Am5NQARdRZVcMo4/DX1jKPavLIaXSUghg5UCLBhHc/FMKK4GtY
	 SlK7F/Mpn4QCoXHtvw+w3He7344RlJkFWvNh/3z7jmCBIyfdDV55O2MPCSk26xWlYwN61
	 c2unjxiIyZu1ZBXtSeL5oII4w2JExQVLlZBdraiC+EiaUDDu6MnbjOagdbTCotobnMxZV
	 eAeOhEvlFIvK3d/2zi39RHb+KTCpv0Mv49tJIhFBb+wbtVpILeLYpRE1wKjGcVduHr6lE
	 q/heLWV84kovjPzLjDPzklJgeIUrVmYMTHXnhUWeRRntEW4DBbIp2r1I7Kd5HLHt6Fw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795812837;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:In-Reply-To:References:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=Zgr2f2gcXGX0eIaBYYdBksXC6DtS/rpZ9YczQX0ZuNg=;
	b=v6dpHNoy6HU9wy6tWXm962S09gsHBIajuP+maV1x21VX5eiDgw3YhehK7i6Mdox1mUqL
	 5gF3eW/IZTXrlDIZoV/804oDuaFcqZhtjOq3Z4KVWkhUOG7kXZcTkGCQMJ+RIzDCObtPg
	 /ZsAkEZMGjBAdwZOGEeRtVXWQMkojzRZ40cBlI+E1MJ03w8EqKDte9yEC6+hb00GW0Kg0
	 UpCp4I65jEvUYwPI65MlRJhjgv9mlBGkpOwn0LT3GvzPOeQEz1NuaLlaRe2wXwyCtuTxI
	 uEQJ/Vmsw33BuwryqmpW39N+SgQqKEKyDSmrcEFJXz5xPGvuJ55iI+0Vg4ksX+Smh1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D3hCiQDg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFBB606A31F;
	Fri, 27 Nov 2026 20:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D3hCiQDg
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795812837;
	b=VG+WEy5q6zwXGbtyL8X6k0eIpqvvidUKpuCdEz9fIh2mgXiGoTC0LCzCJl1imkfZqrEr
	 YE3mBHSpxcy8kL/zvaDXFF0+efa0fkR4cCW/Mbf2buYipx5mjA+f/ZsFS9iERkexnuNZh
	 YZetzCw5FFt41VzhSDM4SGM0sQSbNWqfEPykj8tfMBZQj/Mi4Gn9gepDb4BCrGMXtIZwg
	 urR4qawLmygaMBMYEE7KsjEaKZ9HCJ0bo+tIHhlTl5WBzL4t1PTQcNRLaNE4reGf8CFMy
	 k3sGfVRJeHg5ixw2XSlSBmJVygpRUVPXHqf0OT1gC3LidEdnPWtyKvtBFQ+POKmh6CA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795812837;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:
	 In-Reply-To:References:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To;
	bh=Zgr2f2gcXGX0eIaBYYdBksXC6DtS/rpZ9YczQX0ZuNg=;
	b=01RGFQj5o4DJanf6gJctsL9E+nLRaVl8Mj7Jqs3wGIbWo9g1B/faQLMyzZYddwGrk/xl
	 xx099yVFk3p6/g9XGbds08DN4DRXPb9ZOngfqR0EoXJ66uKJdUlc5UMoIrbnRUyT+M07T
	 84y4HsgxU3EaY+pDzs8/T1vcv9sMzLN8ZgIEVI9cDhptEKPvRq2rDv8rJEk+MrgrjWWC/
	 VUTykdZ6B/dXgltmNir+nxZmhD8JsUUlajrRxSwi2iu4ZW6ggAOHEjTNZCFHKdO5m2WgA
	 xnHQDAqkF8s7xfESclDoYkAOOq3h6cAhNhS5hb4Np1STUPykwDsnMf3zovGw8xyMg0A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A7F5A1F000C1;
	Fri, 27 Nov 2026 20:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795812837;
	bh=Zgr2f2gcXGX0eIaBYYdBksXC6DtS/rpZ9YczQX0ZuNg=;
	h=From:Subject:Date:In-Reply-To:References:To:Cc:Reply-To;
	b=D3hCiQDgu06mL9SNevY9zCZNGuRPjR2M12iI6QWUSpks+q2cT9dOdfzcKu7v3LHaZ
	 UeCZvWahVBwJPFuvYvl0YQ6UNArslof3BjVXcjnbh1w870eLXGaUFdn6i576SxZm6y
	 eI8EVxh7UdTDofLKCVukugDNnD2n3jTkKxfBOqtSggA5O0uOzFaB2DjN6ldzXWH9SO
	 Jjh2S+N7zPsDE7Cp/P1adV9zHKDbEdOzfCby93or6N36eaX1nGMDdPWMDB8GNCGgVA
	 UhSUsJP/iGkSOlbqb+BT/ctH4YlhzwCVlGvnH93cRc1GvU4MbmY+tKCbuJZL/NQ3Dn
	 7TsDREFyEGa5Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 232184DDD1;
	Fri, 27 Nov 2026 20:53:56 +0000 (UTC)
From: Dickson Wu via B4 Relay <devnull+dickson.wu.certik.com@kernel.org>
Subject: [PATCH 6.6.y 0/3] usb: typec: qcom-pmic-typec: fix late probe and
 debounce teardown
Date: Fri, 27 Nov 2026 20:47:00 +0000
Message-Id: <20261127-typec-66b-v1-0-6fe3a0983e5e@certik.com>
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
X-B4-Tracking: v=1; b=H4sIAETsCWsC/z2MywrCMBAAf6Xs2a1JhAT8FfGQx9ZGJCnZKJbSf
 zdR8DjDMBswlUgM52GDQq/IMacG8jCAn226EcbQGJRQWkplsK4LedTa4ckIZ4SYTPAErV8KTfH
 9fV1Aj3pc4frT/HR38rV/eugsE7pik5+7Ykqh5vzA7o//P+z7B8NmSj2eAAAA
X-Change-ID: 20261127-typec-66b-370b700f7dce
In-Reply-To: <2026090807-unbalance-starlet-1c55@gregkh>
References: <2026090807-unbalance-starlet-1c55@gregkh>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>, Johan Hovold <johan+linaro@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 linux-usb@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795812420; l=1871;
 i=dickson.wu@certik.com; s=dickson-b4; h=from:subject:message-id;
 bh=KbCi70Il9pHN83uuGT+W9IodsOWuIbZFQi3JcBLLZ54=;
 b=qFeFeZzyk8L23BGi8ucRQK5g1wBLbLqCpDmKE/59tgaWhwU0GJP+f8ykG+1vWTpeLKCDX6jOS
 vYTWvFner1fChgu2njaPA8n18v95qxMRhWBekbE5O6LBRyXrUPAdQfU
X-Developer-Key: i=dickson.wu@certik.com; a=ed25519;
 pk=fxH7FS4FdojeJSGLJzgKdfO51Rvr4EW30yinj2mc1vg=
X-Endpoint-Received: by B4 Relay for dickson.wu@certik.com/dickson-b4 with
 auth_id=1647
X-Original-From: Dickson Wu <dickson.wu@certik.com>
Reply-To: dickson.wu@certik.com

Patch 1 unwinds port startup and TCPM registration on late probe errors.
Patch 2 blocks new CC debounce work and drains pending work on port stop.
Patch 3 does the same if port startup fails before the IRQs are enabled.
The two debounce fixes failed to apply to 6.6 in
<2026090807-unbalance-starlet-1c55@gregkh> and
<2026090836-sublet-submersed-cfc4@gregkh>.

The late-probe patch uses a newer driver layout. On 6.6 the unwind
calls the port helpers directly and keeps fwnode_handle_put().
This branch lacks disable_delayed_work_sync(), so port stop and
port-start failure block new debounce work under the port lock
and cancel pending work synchronously.

Tested on v6.6.163:
- The three patches applied cleanly with git am.
- Base and patched x86_64 allmodconfig W=1 builds passed for
  qcom_pmic_typec.o and qcom_pmic_typec_port.o with identical diagnostics.
- The patched x86_64 kernel booted under QEMU/KVM with
  CONFIG_TYPEC_QCOM_PMIC=y and powered down normally.
The guest has no Qualcomm PMIC, so the error and teardown paths were
checked in source only.

The backport and the test runs were prepared with AI coding tools
(OpenAI Codex agents, with review by Claude). I went over the result
before signing off.

---
Fan Wu (2):
      usb: typec: qcom-pmic-typec: disable cc_debounce_dwork on stop
      usb: typec: qcom-pmic-typec: drain cc_debounce_dwork if port_start() fails

Johan Hovold (1):
      usb: typec: qcom-pmic: fix use-after-free on late probe errors

 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c      |  8 ++++++--
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_port.c | 20 ++++++++++++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)
---
base-commit: e2bb30811e063ce0db964484357973b855b06572
change-id: 20261127-typec-66b-370b700f7dce

Best regards,
--  
Dickson Wu <dickson.wu@certik.com>


