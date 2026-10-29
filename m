Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793266388;
	b=KbQkhpyh2wGxFlKTBQKHU3WWR50wFjf0NhPDQd3Gi1SjLKq6f1sKGDln4IfXRwmIiF1M
	 MXW22JskcXLrRGoD9M3WjM5HOogu0q20FqnnWqzCeKdEQE244YrQiYTpNb2soGVy2f1aS
	 3XkJmmqAHOS2AX/x5p329Xz3Q7nVMzSQ6pa9P78yBWXBfQARYJJs/iGR+dXayeld95wlG
	 +MKj6Hwj6Z+11q2xF+saEpnmefX0WqTNoRrbf0dc9GBiEJeeklnfaBKGB2CBO3pdi92xX
	 IPODJkju+Iz9+19WWokk0es7tXZ9sNRoXf723dpam7zWo/ngqZMZxiU+ubVTvkSTfgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793266388;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=C55KO/8LL7TeM7rrJe535Zu+Vqk6b6T0kEJKod4ZKxI=;
	b=WqW0Xme/CymVka+qTnGmeLQ5rMXE7B9XuYnE9DlG5PE6PyF7KZdTM8lCH+Y77Y53bKy7
	 ZnYeMQu/zOpbn1eamz6RFX4tpga5XRFTDu3fnX5qZucTXsTMgaomr101gYT6hwLYLQJWs
	 lkCkx1kshQRouCMNbG1xUpZY6LKL2l60iaI++EMKT1W3OZz+k2NfAO4YcerSKaAltKxwo
	 BuTGsgsUkUSXpk0zxOpSqOfUqoRCkZNvAAoQxjB0LTFiNTdjTvHhSJyRh1EQoen2dn2mZ
	 U5WzMHb4/1XQvCS1gbTae6FDHakf51s/zZDrnxLUVVjVoiQcW5CZXOvZm6KGjhqJO9g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QZHcE+1L;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC15606A31E;
	Thu, 29 Oct 2026 09:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QZHcE+1L
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793266387;
	b=rCft0zHji18SguJxH/z6QlCfB4r5xDpJeI5IgHPg7XgV5tVVYQ4eSJjyGQ2TFXGsb6Zt
	 ei8sANmuaF2Z2e4rUmQKuVCi7KxNa/1asYlVH74Skc+OjyNN8bcZh5RIwDT97iYz7k47/
	 hxjQGdh6kpBYTI/xPqhVZbOmIWV/DS3cId6OJzhpfssRBRVBCvSGHm8vulBDsMOs/dMuJ
	 KjL3QH+1ic0usKrcx2HasrILVxMPw6260y9x+KqHBpEk5dU0FlHSDJZC8Otd0oHOlxOWz
	 iF5LFyN7G3cDKpAi7wOqfDTEimNp+hRXIDwkXUDVgBbHFpUFZZDiDLqK4/cZhpDTg1g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793266387;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=C55KO/8LL7TeM7rrJe535Zu+Vqk6b6T0kEJKod4ZKxI=;
	b=WUznoOH46h/Uwn5Xs+w4eICrh9100hp950bggaiBhacu+Vy5YMgxDRxeqpiIVjqiHnGk
	 8gkbD8nggoAUmtUzEqhKr6HhT9u0YRWQkxRbdJffk0YtUTBXObYelIO0rHre/8oCnytET
	 nYOREjzywT8NM3bS0QdoE1pJbcam4ItllNB4OcC8C7iYrVuu+DZ0S7pxBiuwc5fCWmbaW
	 wGpTlK48d5d5jsKL1R4yAFPM4f7SuwHmJWmHaU+y1XCX/fOXIqYbJnoMAJSBCxgwgwK66
	 kFzALIQg6y5Gi/5T/r7H3kJ0dwYQH2Fs7+MEaDUBa32+NvBt4jqJCcmldUuQb1jBJxQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 851171F01828;
	Thu, 29 Oct 2026 09:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793266387;
	bh=C55KO/8LL7TeM7rrJe535Zu+Vqk6b6T0kEJKod4ZKxI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=QZHcE+1LDuDFXTZuR9HbmBKlXPy89LfP8X0aPZgWpWv/6oAazn33A2shjVmuA+2hZ
	 HSDzhXgOf77W6QNE6WsED5TymzIwBR/yoDJoN6IdP8F6nkiIXh+weoPN/IvrPfAF+p
	 GKUvHvIznFVGJArvpARnx5vZJ9g2R7oeXAPKlCuyz/D/xMmyPy7WlRvktUUHPxoKlk
	 aLbZrrpmiTSKvEgZpkO3g9oClI33o5aCDAzTvyyn9N4Rru/UjtpUpZFRwUNLw3ZgcC
	 I07+ghO69UCya7ODVmQ4XfFmhWB+ii+FFKupoe+CeQALR+xKoCO40R7Gi4R1NwRbK4
	 ba5TTfGl5KleA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0FA9B457CD;
	Thu, 29 Oct 2026 09:33:06 +0000 (UTC)
From: Patrick Fischer via B4 Relay <devnull+admin.tsv-stahl-riesa.de@kernel.org>
Date: Thu, 29 Oct 2026 10:33:00 +0100
Subject: [PATCH 2/3] soc/tegra: fuse: Store Tegra114 CPU and SoC speedo
 values
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
Message-Id: <20261029-upstream-speedo-t114-v1-2-81457cc9d94c@tsv-stahl-riesa.de>
References: <20261029-upstream-speedo-t114-v1-0-81457cc9d94c@tsv-stahl-riesa.de>
In-Reply-To: <20261029-upstream-speedo-t114-v1-0-81457cc9d94c@tsv-stahl-riesa.de>
To: Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Prashant Gaikwad <pgaikwad@nvidia.com>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, linux-clk@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Patrick Fischer <admin@tsv-stahl-riesa.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793266385; l=1694;
 i=admin@tsv-stahl-riesa.de; s=20261020; h=from:subject:message-id;
 bh=+yKNYi2IHZusPUhtNKXAX1JpKETKpwUXNfPwjmWY+ag=;
 b=4JvZFiQpSbPsGARZvmxmSLZr+iMyy10+lb4zMf6EirZcluFDTS4zduw3frxa/Auj8QFJ1IhWQ
 QgQfcVAuxW8BWyH+olu/97RA9azIN1bbXEmxe+gPJd22OkQbWQ3nkfk
X-Developer-Key: i=admin@tsv-stahl-riesa.de; a=ed25519;
 pk=D+v6EloYcEY9PIUHFyTM5sqcGIU/fIXzLUdkR8vjAtk=
X-Endpoint-Received: by B4 Relay for admin@tsv-stahl-riesa.de/20261020 with
 auth_id=1251
X-Original-From: Patrick Fischer <admin@tsv-stahl-riesa.de>
Reply-To: admin@tsv-stahl-riesa.de
Content-Transfer-Encoding: 7bit

From: Patrick Fischer <admin@tsv-stahl-riesa.de>

The Tegra114 CPU DFLL computes its OPP voltages from the CVB tables
added in commit 5aba939e80f4 ("clk: tegra: dfll: Add CVB tables for
Tegra114"), using tegra_sku_info.cpu_speedo_value. The Tegra114 speedo
code computes this value but never stores it, so the DFLL uses speedo
0 and only the c0 coefficient remains. For CPU speedo IDs 1 to 3 c0 is
2190643 to 3395401, so "mv * 1000" in round_cvb_voltage() overflows and
the OPP voltages are wrong.

This is currently hidden by a zero voltage step with Palmas regulators,
fixed in the next patch. With both fixes the CPU OPPs range from 1000 mV
to 1270 mV on a device with CPU speedo 1742, which matches the vendor
kernel.

Store the SoC speedo value as well, as Tegra124 and Tegra210 do.

Fixes: 5aba939e80f4 ("clk: tegra: dfll: Add CVB tables for Tegra114")
Cc: stable@vger.kernel.org
Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
---
 drivers/soc/tegra/fuse/speedo-tegra114.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/tegra/fuse/speedo-tegra114.c b/drivers/soc/tegra/fuse/speedo-tegra114.c
index 1e6c2b5be759..8bf1a1b1287a 100644
--- a/drivers/soc/tegra/fuse/speedo-tegra114.c
+++ b/drivers/soc/tegra/fuse/speedo-tegra114.c
@@ -92,6 +92,9 @@ void __init tegra114_init_speedo_data(struct tegra_sku_info *sku_info)
 	cpu_speedo_val = tegra_fuse_read_early(FUSE_CPU_SPEEDO_1) + 1024;
 	soc_speedo_val = tegra_fuse_read_early(FUSE_SOC_SPEEDO_0);
 
+	sku_info->cpu_speedo_value = cpu_speedo_val;
+	sku_info->soc_speedo_value = soc_speedo_val;
+
 	for (i = 0; i < CPU_PROCESS_CORNERS; i++)
 		if (cpu_speedo_val < cpu_process_speedos[threshold][i])
 			break;

-- 
2.56.0


