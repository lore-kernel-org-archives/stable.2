Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795454565;
	b=eUggj9/ZXJbe9EP8stL4P3mVSJStR4bXdmaeLf/Tn8V3Tvj+HvZjOsqxzPYJJ+z2lY4j
	 ou4MGsIxoyw8KFfJhvMNizMPVm64LUByQfGzsgevOBGLXJrnOBX+086yxG8Wyxhaa0aLH
	 /juBk6DRwmrDoBUaFwRFjsZug5YDe4amfmI/K4xEUGLG11auG0sxk5hKKmqdnfM2a+3l1
	 zxure9FSNKh0kyuFLLTFdm0pq1CNXHr4lAE8WIcuTzo6LSzCvQ0IfPvhs0TfFXwNiYAAf
	 EwT4pOg+j3CwrbBSkeFhxCmiA57jifXPcTlAsVfTvjtLvlSzr/LxRa1fsScmyhItiiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795454565;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+FacmnW79BHpI/Pgb5t1bHZuNRzQeNjr2JRVjl65ihs=;
	b=t8gI4QUtLhHmeJwJIyWydIeWHVlPBJi+DsTlgCmjyZ/08dCzuRgfg8hCFkYolGuxeKQ3
	 VzkupFeLo49BMDUueH8M7R4lWQMrd9yOkV/ssuEOxoHduM1XlmSuF0pw91kGniQJq292s
	 5/lNqebV/8DVwreWxpGLXGUqSWLifRm3PZjV6xCTGmeTF+O34vc+tXuNScLamlec2+ezx
	 zciq9bwnfHxIKi3hsoNZbZvgHWF9baNGr6zv9JoImdQtWEGkl/ckKNeMBOe3BRjmCZMbB
	 aVeVuNdCcBvTz4t9D/nq+9O3g1OaXpqxODLyJza1GOVFIyC76TocRuB0tb5aAOMarOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HafcotNC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB38D606A33C;
	Mon, 23 Nov 2026 17:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HafcotNC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86F11F000EB;
	Mon, 23 Nov 2026 17:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795454565;
	bh=+FacmnW79BHpI/Pgb5t1bHZuNRzQeNjr2JRVjl65ihs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HafcotNC8GFbgMCUkU1mSSZIcsiLRm9vJZoRujOni1mS9wmJNtk9b3wZAiDP6SGic
	 /ucs5zSjv2Y92VUcBGTZwG2g/00qWvHz/Kc2uY16cwvzX5o9PeA5na3nnKPAYzbFLH
	 0be2/z0KFFm4SGI23Wvnl1UtKN6HQrh3HgDgjh/uuAAIM1J6t6Kn4vQO/779bpPbdw
	 7NvJiJuK85/Ccf9LYZWchSZQ3HBNBiADNwVizNa6/zjj+AcjUF78yC9bZJyBFRbcMy
	 xROPWHpxJylXBpKifTG8T6wlOtUPddLZYd+MTsWC75uhM0QQ0rztzm6M7GNBoC6P9i
	 xe4IMMnqXKeAw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Rishabh Bhatnagar <rishabhb@codeaurora.org>,
	Siddharth Gupta <sidgup@codeaurora.org>,
	Alex Elder <elder@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 08/10] remoteproc: qcom: Skip unregistering uninitialised SSR subdevice
Date: Mon, 23 Nov 2026 17:20:52 +0000
Message-ID: <20261123172140.3547896-9-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
In-Reply-To: <20261123172140.3547896-1-lee@kernel.org>
References: <20261123172140.3547896-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If qcom_ssr_get_subsys() fails in qcom_add_ssr_subdev(), the function
logs an error and returns early without calling rproc_add_subdev(),
leaving ssr->info NULL and ssr->subdev.node uninitialised.  When driver
probe unwinds or the device is later removed, qcom_remove_ssr_subdev()
unconditionally calls rproc_remove_subdev(), dereferencing a NULL list
pointer in list_del().

Guard qcom_remove_ssr_subdev() on ssr->info being non-NULL, matching the
GLINK and SMD subdevice teardown helpers.

Fixes: 5abfe5cf0b83 ("remoteproc: qcom: Add per subsystem SSR notification")
Closes: https://sashiko.dev/#/bug/linux-5594c348-0c41-4482-b001-481878256d30
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/remoteproc/qcom_common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
index c53190f0c537..6fd92c33392b 100644
--- a/drivers/remoteproc/qcom_common.c
+++ b/drivers/remoteproc/qcom_common.c
@@ -537,6 +537,9 @@ EXPORT_SYMBOL_GPL(qcom_add_ssr_subdev);
  */
 void qcom_remove_ssr_subdev(struct rproc *rproc, struct qcom_rproc_ssr *ssr)
 {
+	if (!ssr->info)
+		return;
+
 	rproc_remove_subdev(rproc, &ssr->subdev);
 	ssr->info = NULL;
 }
-- 
2.56.1.750.gf70dc682cf-goog

