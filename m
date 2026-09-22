Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578F43E8C78
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 21:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790114344; cv=none; b=dZHvlH1LM4lxjvOLAqk47v4x5tpFcKnzy0lebeeMLfD0GbpgLJy9qu4/BSdlHcZQcg53fLQv4DrRAN5GL/HedNJoZli1e2xyQ+kTiqFY9vWc+gGW96+qSW1c7dwO2ERnZgEKRvOCGzA0StDn8v7RPVPkbnMHMycteYoSsfPTn1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790114344; c=relaxed/simple;
	bh=GDLSwIlcQiBPIYZW7mwXqbHREJdT2u8UXhgtTj5jkiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZBoGrnBnE7CfiQmujkeotwM7JVPaj74NSt6Jlc2tNemfn49YufSRu/mDl6H/wID78K+UALMC8aAYcNzV1P01pX3TJQqqROZ4YzzKJOZoAUIGbr48YOTpnQ3BzmP36eD5OnaY9LrCyxNU4AOSpmMH1NJbrDOz1r/aSQ9P7f5/KvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fH68fVsw; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fH68fVsw"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a5b6840edcso2313541fa.1
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 14:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790114333; x=1790719133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7q1/TXtAUbCspe1fPBPxnd3YpWlWRbOHARWf7oPjbO4=;
        b=fH68fVswCVi4Umz/jVByv4pybKzLg9XGLVQPwpvvajGa29SOARqDPS6GSPSaWKKw3e
         vf6l6C71pCbMvA39C1qtddrsEgiH8RrkWceojT4QZxNMC9eMGS2QzJeFKdBPr+kWkQsY
         I439SxKSGoyG55bPbzUi30F8SCWbvtO3efeqw1Hu7afO6+vvVUVJgWXbpa0roghfcj/X
         mJAfJXvAFmDTlJgoImW4Ls1jPwBH/S0Wk3mhIua++RO0N2sBK5rE32/K+eNItuYPwwNw
         C2N2+PtNzRFb6mDshPV558OipIKqFO/33wM42oEBw+BfsV6uOTy5OC8rTyWCp33yM3pj
         Ie6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790114333; x=1790719133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7q1/TXtAUbCspe1fPBPxnd3YpWlWRbOHARWf7oPjbO4=;
        b=KzQLtU9BvH1x8LCBk1OqcdTKWN4XKSZ/+OqTCwdRiAHNM8nQMnccm43Ayi5WaWgodE
         r5n0ctdndj9cHTNaPdfGpYaQt8rCJOvQ5KGBYmPQCojp973L/LahcvD5OqlY97P0aqef
         bSHSrDxHyN+YW4J/vtXWkgHVhDLkKOdBk59vd1zMqzeKmN1NK3Jseoc+BypShN3umeZ1
         cNT269N1qUfL6pzW8i8EN5pf/nXgmWPiGkUGiMtNyIMxHILE8rYPLISIeiEHQknaS/4R
         QfPAFaesIVD4sX67V2SVm3JszyVG1NVsWxWzPRSiMggExAP2qJ1KKhLdOGb5ek3tVcw6
         rm1w==
X-Forwarded-Encrypted: i=1; AKwUvBypmeqeptsraK9FZEP9bzjHTdLQsyZeLSRipW0QEGwL/TOrNNsiqEIXEH23X5Xm/CLFe8drwKk=@vger.kernel.org
X-Gm-Message-State: AFuF++ktnSQ6Pxc/2MrzDd7HwJI62o++/8e2UBiwveA2NMfVqiqYjlGL
	fs7j0eFOZCl3t+nn28b1WKOlngAHd0Yf5djeCCUo4zQm5NVZqZFuQ0Ke
X-Gm-Gg: AYBFou3aR85FpzBv+u3D8qJ8fztKBNUPZpwLqhyOXv+qW8tnVgW1m3OLycRNKsOe4UP
	Og20PhmJsHxjngpRun04hvZ7sHDkC/UCR67zx2Y2aDIXx9780gyS2vmnapvbedlaKMy6nwNG/Pu
	gf1St1fC0vPqXkGNKOWguHQGQDDVsomSKAFZdS4g03XdeI8VxZu0uF4BJ2vJF+Iwm/EUDE4dNHU
	AXlLj2Rn7fQZcrcWNnmD3+hAtvYmdsetPwahajufhfKox9oR8AxB/XcB5ajYNG8FIQ0dF57MZ6I
	PzwW6SKLrRcWFDYc4/thQCv2vcX9YZkBDidXdxWuxTkEIeURmHeKKNgU7DoEFi9ZOWs91J84M4L
	UyjO95h0Mu0dwDh3ocj3OtMjFjPMUWjp7gPv/pVN9xX0SJ+HLkQbEI7i8gNG/aj8goyUpfk4n37
	N0M7MoIFxpQVXbfXWTURQUhFyDD9VmxOOAi/K3ClsmbGy3vHaZXSMnU3iQ/0PrIhdliHAwHiW0O
	jDhHFY7QbbIJTw=
X-Received: by 2002:a05:651c:2119:b0:3a5:df43:7628 with SMTP id 38308e7fff4ca-3a63057cf2emr1261361fa.0.1790114333042;
        Tue, 22 Sep 2026 14:58:53 -0700 (PDT)
Received: from localhost.localdomain ([109.195.90.36])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a62f53b3d5sm1974651fa.40.2026.09.22.14.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 14:58:52 -0700 (PDT)
From: Vladan Kalaba <vladan.kalaba@gmail.com>
To: gregkh@linuxfoundation.org
Cc: ovidiu.panait.oss@gmail.com,
	gustavopiazdasilva2102@gmail.com,
	error27@gmail.com,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vladan Kalaba <vladan.kalaba@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] staging: axis-fifo: fix integer underflow in tx_fifo_depth
Date: Tue, 22 Sep 2026 23:58:48 +0200
Message-ID: <20260922215849.16739-1-vladan.kalaba@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix integer underflow if tx_fifo_depth < 4 in axis-fifo.c due
to check in axis_fifo_write() subtracting 4.

Fixes: 52ff2b840bc7 ("staging: axis-fifo: fix maximum TX packet length check")
Cc: stable@vger.kernel.org
Signed-off-by: Vladan Kalaba <vladan.kalaba@gmail.com>
---
 drivers/staging/axis-fifo/axis-fifo.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index 7bb35e11d1dd..066124122caa 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -413,6 +413,11 @@ static int axis_fifo_parse_dt(struct axis_fifo *fifo)
 	if (ret)
 		return ret;
 
+	if (fifo->tx_fifo_depth < 4) {
+		dev_err(fifo->dt_device, "tx_fifo_depth must be >= 4\n");
+		return -EINVAL;
+	}
+
 	ret = of_property_read_u32(node, "xlnx,use-rx-data",
 				   &fifo->has_rx_fifo);
 	if (ret)
-- 
2.53.0

