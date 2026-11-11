Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=85.214.250.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794393618;
	b=kFZFeJ4YyWQVdEXu1rv89izq8d9QXIS5G19BKYVzCr4oXhDi2ho1/1F/vKiSAbzenpr8
	 60DDF9ZRjRLxBEz0vNc5pfhyAxRqhbpsdqx4FAYrMedZoPDZ8kzrs+KGpSzg7578saLt0
	 go5eEfC/7Wb1S2K2PdAceNbr20B334DaT+624ctYkUIYHLqfFukoUqEHAB3nQIQQtWoCP
	 0E0WN/YeETFRcg2j1m2YbpZoH/5Lp71M9kik1FvICK1jdD1CdP3FzHHUSkLwBOiwJ5e07
	 cxhSdext8wctvpQlPiUqLAdWjxGZ7VeDIMk5OEsI3p/Sar3Z6pxHd93GNeuudoillvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794393618;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=yQeS8dIWSz9paRxvko30HkRAFyK3DIJ0S/may3b6YJ4=;
	b=YrXahmIP+wUAEcRc5siOP6jAJAhrhhYQK+GHQm50AR9HR33NdSg2nIEPWPsZLB5cVLHH
	 zqq1MB1HqG8AX+L2fSzgsr7Pojd56dL8Es75f0BjFlBj2KK7YkyrlDFm7zptVvZzOgr1x
	 IlHxrflGPtmp2drNfAR5AdL7LEpOF0so/50wu1GD7eQJ4xb/crLKqIM86l2PKFQJVmRf3
	 xzpo4xm1jw6kP297f2TgDV3TOBbszpHXVRWbMT3wCObPfpflA0tneI+IsMISD02U/NZQr
	 AJi1PRZ9tocSOYzGYH+8zmC5HxpU6M4WIeNOh9mqQyULzpsYegwXo6bXph3OQasQsaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=8bytes.org;
	spf=pass smtp.mailfrom=8bytes.org;
	arc=none smtp.remote-ip=85.214.250.239
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BAF606A89D
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 10:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63BAF606A89D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from io.home.8bytes.org (p200300f6af404a0070a0fd992ce44cba.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:70a0:fd99:2ce4:4cba])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 47E4D243D49;
	Wed, 11 Nov 2026 11:40:10 +0100 (CET)
From: =?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>
To: stable@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>,
	Joerg Roedel <joerg.roedel@amd.com>
Subject: Linux-stable backports for IOMMU CVE-2024-21963
Date: Wed, 11 Nov 2026 11:39:55 +0100
Message-ID: <20261111104001.216548-1-joro@8bytes.org>
X-Mailer: git-send-email 2.53.0
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

From: Joerg Roedel <joerg.roedel@amd.com>

Hi,

Here are the stable backports to work around an IOMMU hardware issue
on some AMD CPUs. The issue is tracked as CVE-2024-21963.

This posting only has the backports which can not be cherry-picked
from upstream (all stable kernels except 7.3.y).

Please consider for inclusion into the Linux stable trees.

Thanks,

-Joerg
