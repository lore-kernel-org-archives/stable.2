Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794294689;
	b=sG72TGFOboWiO7iPVsEN6L12uXD8NEBVxpR+ZBJssYFGSmZyyXjl89KRBWOBSYRgU7Rt
	 ANgSts7EDIgOB4FJ1J4wP+QbOEDjAwQSKdxkCBXjwUcJsmPqT1KvDHOENYD6CCzTnlQOy
	 QhmCjfTzW0zjUtp9SG0qAWk6ECrDs+E3hx5zmJhgMI22nRwFl9pU5HvobYevrQR6VA8uG
	 cNqYMqIbhCButZbIigYvhiNIxRSdQR+3tyFEtqq5cvhb2knfIs/hx5HKlY+Qxv1UnbNC8
	 LhqPHIaTdIpghvn2HSfdxdYAIa7nUma9UDsG6O0KRIToUAxUFle2NSQBG8xfD17Xjyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294689;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=wkTqur1hikVaY6/qIWQOAtbgg5P47n0a+yvq7Tm9TfU=;
	b=u84GyPxOUXaThzvDoi+1awpxrimT50b3DFhrqzt13k0uvZuTocwpFZCHgoddHBNfCKfF
	 vjJgAGPGulptApdinr8lCJanerQ5atl8nECAZ/V362UN2mY1S//njXmdFqhKmJbkaittV
	 T4VDQxYy9hU2PWzcj1oy/x8NWI/AE0gydbfH9KWtjcldrePtNJ4ETTBxaJ54o+bxXFfCb
	 nBlbNDWcniGAoruaSvvSVCVmbRilAOybd5yya+qQo4pfUXhqVRV3de6KrRcBQX7pRvdUf
	 m5KdSIep7fJgRBiFKyYXU95Wo3UAAImVdYshFKYwfmEoKXrVbDu4UiVSYDyUX7tOiPQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rs6YfbH2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EF8606A330;
	Tue, 10 Nov 2026 07:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rs6YfbH2
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794294689;
	b=NHuvs0u4qfH+tv70or5oCqNBA/lkLXRc95FArjD/54RO2Ghox4i8Yojr8y3msfyCVgny
	 3mbDffEQS2DE5Hj9ukQaN8wA7RN58PRQHWzJpp7jj/w5rbGnaJNhNbiSUJ8XXqNNMmQFE
	 qcnccA16zu2iGGRXVQwQRRZzJwfv6we2pPhyBqaommqIiklGMTWoGJvoLP5q4+nDShzcT
	 25LLczSc0EmtO+XWLjC9t3QUE5fBs50sZE+ElnDIPxgoWeAneHqJ0E25QBx3FdifTBWBD
	 x151rPEEkficDkkOXsSrW9Me5P7U7pfepWBCaTI6Ej/RcddXsAnjKchig8nwGWWWckw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794294689;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=wkTqur1hikVaY6/qIWQOAtbgg5P47n0a+yvq7Tm9TfU=;
	b=Ug4EvJofkw0QJTpV7mCzjk3a+TM/E7Klugh8ZtjnfDDHWGjD0hHLN5F7noTuT2ENmtQk
	 fIvi6+8wmkePE9jCTFt2T/kE8mGFnJwK8hFHqbKGUuv8eg9xDqouaFSBaINuTEM20xa02
	 jxO33lOEvySMyW5/axbKZMVblZWRI+Cy/K9yLe252cgjzOtTlfbKQPKexmwmDvVbzj/+x
	 JB1I0xqTDOo9S1JsyZ/90SeTMvtRekxORT4TmOsJBU4Flx90r46Ku/wlhEOwCKr/v6z9H
	 jLFtcyohIcr3vC3kZuXmeC/RGsN4e4woZJ3U4vsPuzSLeAXirgna8zXzUKakR11yaLw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7F82D1F0089F;
	Tue, 10 Nov 2026 07:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794294689;
	bh=wkTqur1hikVaY6/qIWQOAtbgg5P47n0a+yvq7Tm9TfU=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=Rs6YfbH28mNJq2cO1k+/CQvPZzQxP9XJyScvSPC/m78lOXVIJ+BcW8gAjmCyXR0mO
	 Dp9Se4McDraF0utY8Rk6AqBU8dNp3eF9SBxEiN7PTIrtun5GN8fmwIsSdVmfxptgzn
	 dhuHQzTyZ4pUv1O6q27FWYlQC1a8zE8zhGK5QcnxFLX4SUpQSPbzDx1w4A76KYN6no
	 hnLROI/Y5R3b3kDn6Xoic7YZNLC5g9GpvqMIZ9PzKCFy2/SAPAr5n8TrYn9gCvyiWT
	 kjsHC5SKy4jRabABByUybFPu4CfLFDRwnDK6lmcnnkQqKCHDRpbozUWBby5ba0MesK
	 +eCiqjkG6u5Yg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1357F4891E;
	Tue, 10 Nov 2026 07:11:28 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Subject: [PATCH 0/3] pmdomain: rockchip: fix the probe error and deferral
 paths
Date: Tue, 10 Nov 2026 07:11:27 +0000
Message-Id: <20261110-pmdomain-rockchip-v1-0-6b9fa6ebaa86@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw7CIBBA0V9pZl0SwAfRX2m6QBhkbHgE1JgQ/
 l2qy7O4t0HFQljhOjUo+KZKKQ6IeQLjdbwjIzsMksuzEIKzHGwKmiIryWzGU2aH40VpicpZd4L
 R5YKOPr/nsv5dX7cHmuc+gt6/gIeeoHUAAAA=
X-Change-ID: 20261110-pmdomain-rockchip-3497a2e7fdf5
To: Ulf Hansson <ulfh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Shawn Lin <shawn.lin@rock-chips.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Kevin Hilman <khilman@linaro.org>, Caesar Wang <wxt@rock-chips.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Igor Pecovnik <igor@armbian.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794294687; l=2416;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=QoAWdAEzgzL2QuwNz+wZsYoa/Z9SPuRCylTlgEE4RjA=;
 b=hCUZhEAiVVHPN/W3DReqR0LhracBQIiJ4fAnU+xZMyzjHjLbDahebbYCC/AKHaoQzU/BzHuRw
 ZlMANOkzg5rDQdFKewNmpFmG51NPTFrZVQtx0WuhpcE1gMJ81cTt/D8
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com

Three fixes for what happens when a Rockchip power domain clock is not
available yet and rockchip_pm_domain_probe() defers:

1. (Igor Pecovnik) Only the clocks that were obtained are put; the
   ERR_PTR() of the failing one triggered the WARN_ON_ONCE() in
   __clk_put(), and the deferral reason was not recorded.
2. The error cleanup removes the parent/child links before the domains.
   pm_genpd_remove() refuses a domain that is still a parent, and on
   RK3588 (RKVDEC0/1 are children of both VDEC and VDPU) no ordering
   avoids that, so devm freed domains that were still on gpd_list.
3. A deferral is no longer printed as an error by the callers, once
   per probe attempt and twice for a nested domain.

Tested on an Orange Pi 5 (RK3588S) with test device trees that give a
power domain a clock which only appears about 26 s into boot, once on
PD_NPU (a top level domain) and once on PD_FEC (nested under PD_VI,
after 18 domains and their links were registered). With the series,
devices_deferred shows "failed to get clk at index 5", there is no
"failed to remove domain", list or slab corruption report (booted with
page_poison=1 init_on_free=1), no "-517" error lines, and the controller
binds later with each of the 26 domains listed once in
pm_genpd_summary. A host-side model of the probe and cleanup on the
board's DTB, deferring at each domain in turn, leaves freed domains on
gpd_list at 24 of 26 failure points without patch 2 and at none with
it. Normal boots are unchanged.

This series was developed with Claude (Anthropic) as a coding assistant:
it wrote the code of patches 2 and 3 and the commit messages, and I
reviewed and tested every change as described above. Patch 1 is Igor's
change with a rewritten commit message.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
Arun Iyengar (2):
      pmdomain: rockchip: remove subdomain links before the domains on error
      pmdomain: rockchip: do not report probe deferral of a domain as an error

Igor Pecovnik (1):
      pmdomain: rockchip: put only the clocks that were got on error

 drivers/pmdomain/rockchip/pm-domains.c | 73 +++++++++++++++++++++++++++++-----
 1 file changed, 62 insertions(+), 11 deletions(-)
---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261110-pmdomain-rockchip-3497a2e7fdf5

Best regards,
--  
Arun Iyengar <aiyengar1990@gmail.com>


