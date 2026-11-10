Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312649;
	b=FQtK+2AdTeqpsXEWJ6MTWCobmWacKH6MY6MZImbIOUB5q59u7gHlkX3GIALncIEtdsue
	 sov1Uo1FlJoblezJSvGZcYZOdaMxvXi4291FNv/UARysFV7q/bs6kt2Ij0SFTQ/Bozj4N
	 LmDfTQJU6C8/QGotI19AhFk4j8M0bgLLXeOB0FpqBjDUfJRrj9tftTGYFOrFw8jedlVhm
	 XCx3j3/rqP4y7nLcZokgTcM/lnjsdGsEWd1adILdvzvaDznrUXi5+M9xh7q0wmfcK6zBs
	 TtzX7NYH5Ip6WmPghoXyMA/IZwCPW/W/Ys4dRtX2w4qFcQK90oqrYONZFnKdehWt7+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312649;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+x3H0SnwirXUyw+PofM1WNqAxgSzHIdenhzye+vb8Mc=;
	b=zw8QTHLByL1T0QigTT6xPaXTbyj6FvEbeOLw6ZL8jltoM2rW2l19TlO08FOrijfdMbOC
	 roZJMMA/AbFQfWICDJTVuhE6WQ75LetonTTDlmD/van6cIZXH6cp/Wql1BYiN2V93IvH5
	 crv3bcCQaesrStdH8/m7/qz4YScgJEjklM81uoKnQtiK+ECGcMGM5lJILE7MZsYeZfL+z
	 7jjQ+NJTyCncuh5VOmrGTyyJkErAu2BMCvAZKtuZa0bqlquM5/oji9R8PMbnZq3ksmJS/
	 qyP8Pe4ywAbTc22IlN3tZXGkMdkIkXXPHhQ/UE6YLQk0NAA3XqERbRU5njez366Is4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W4bIikyj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82DC606A945
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W4bIikyj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9246A1F0089F;
	Tue, 10 Nov 2026 12:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312648;
	bh=+x3H0SnwirXUyw+PofM1WNqAxgSzHIdenhzye+vb8Mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W4bIikyjLQH/T+t6quhC4bGO1hVJUnwIsoqZD4HjTLItGcSxVlcN6L/WxtY48p45d
	 eoH/CeMvZYIeYp/1fYRDhT0r1Z4MX8O+fN3RhhyhCgWb94U1EqtoMGZtKWHs4Pr9j6
	 iYSbNPi61RIkLtKTRuV+dbxouQtWEToqgXbw3GRQzM1NMe2V9LgT39yOKIFylq/rUK
	 D7lO/Q5MsTCotDGB3XqOld8jsf06CLoU5L/V5EovsCjI7Ke3kZ/eo5UZ/H7fUnhL2N
	 yJ8FMhDJszHN4mjk0vYh5qzn055HvwzVa19xl0ifbTRzAhNDnPeVGa7S797WfSWxSk
	 /k41O6Siq7dNA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] media: mtk-vpu: Remove redundant 'flush_workqueue()' calls
Date: Tue, 10 Nov 2026 07:10:45 -0500
Message-ID: <20261110120942.969538-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060149-failed-5.15-2c50b58d4105@kernel.org>
References: <20261107060149-failed-5.15-2c50b58d4105@kernel.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 360c887a39cb56e75be4f558b16f1b6409ecb93f ]

'destroy_workqueue()' already drains the queue before destroying it, so
there is no need to flush it explicitly.

Remove the redundant 'flush_workqueue()' calls.

This was generated with coccinelle:

@@
expression E;
@@
- 	flush_workqueue(E);
	destroy_workqueue(E);

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Stable-dep-of: 2c50b58d4105 ("media: mediatek: vpu: free IRQ before destroying watchdog workqueue")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/mtk-vpu/mtk_vpu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/mtk-vpu/mtk_vpu.c b/drivers/media/platform/mtk-vpu/mtk_vpu.c
index 87da09148b266..1657575346735 100644
--- a/drivers/media/platform/mtk-vpu/mtk_vpu.c
+++ b/drivers/media/platform/mtk-vpu/mtk_vpu.c
@@ -966,10 +966,8 @@ static int mtk_vpu_remove(struct platform_device *pdev)
 #ifdef CONFIG_DEBUG_FS
 	debugfs_remove(vpu_debugfs);
 #endif
-	if (vpu->wdt.wq) {
-		flush_workqueue(vpu->wdt.wq);
+	if (vpu->wdt.wq)
 		destroy_workqueue(vpu->wdt.wq);
-	}
 	vpu_free_ext_mem(vpu, P_FW);
 	vpu_free_ext_mem(vpu, D_FW);
 	of_reserved_mem_device_release(&pdev->dev);
-- 
2.53.0

