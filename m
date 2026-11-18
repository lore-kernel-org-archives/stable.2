Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=77.108.111.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009963;
	b=fVGRHx+iziXS7cmU7r+aPuO7KT91is2Z8DUkVCblCkz33j4SPwPDrus2phQWlh1dM8nt
	 uudXqJOWwT3gWopIZnj7/QJBvbeFWHLr2eldZgGcUvRTcAFXQwG8sXYKVtDG+Ujy8bsfI
	 p6NrZ/w+D6bGb30gLEqlGHGO9q9olHXz4fYnUJyES6NcCd7gavb8gfZ4GYpL5PVew02Ks
	 2FD1qaRXsFyPD1w/xOEQC/wAP7H9eczJNHduUZvM7MapxfJ7TPTsTJ4PS7lJH4F1Yseeh
	 wcHDHqg9j8QWaVFSuU9+yMhmwWKJDJ3H2/Qeazrr5PE8l9XKvd/BPJAzMtf7QlvqW7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009963;
	h=DMARC-Filter:Received:Received:Content-Type:
	 Content-Transfer-Encoding:DKIM-Signature:Received:From:To:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Originating-IP;
	bh=iCtO8C76z+v3AVxycrUJkY2p7BT9NCr8k81QRtBpz1Q=;
	b=Bv4lIHxUPNm1KZrJBEPyDnjVbImdBZ7OvmVA2+fL6S9UpvBDokUFRqzBL4U7/CHxWTli
	 s8HiHLn4HxUg0mRYCpf+75jaf6P0g83qdRc7Ukc0Y+ASpgA24BYEMLdszhMP+YVMBLRPA
	 9gFruBUi4DDURr+UOLtkZ7zhX7BOD+BmaWEeQMfVRd29Jy7taOBngMSo4SXULsVrm3YeN
	 uJd87UVPSaBlgl0p3fOEbDK6fqPYboOARR3MDFHGKvK+iWQZJA3xHOUeizYd6zHhCFGYP
	 acuLNP8FCGsbh0y/V0mVSZUISDrfMhSUT/BMfCmEbdfyrba5bDHr352dKRvy7S17iFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amicon.ru;
	spf=pass smtp.mailfrom=amicon.ru;
	dkim=pass header.d=amicon.ru header.i=@amicon.ru header.a=rsa-sha256 header.s=mail header.b=SXN0dNPv;
	arc=none smtp.remote-ip=77.108.111.100
Received: from pmg.amicon.ru (unknown [77.108.111.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88FA606A320
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 13:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D88FA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amicon.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.a=rsa-sha256 header.s=mail header.b=SXN0dNPv
Received: from pmg.amicon.ru (localhost.localdomain [127.0.0.1])
	by pmg.amicon.ru (Proxmox) with ESMTP id F18F21017D1
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 16:52:35 +0300 (MSK)
Received: from mail.amicon.ru (unknown [192.168.0.59])
	by pmg.amicon.ru (Proxmox) with ESMTPS id CA49810144B
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 16:52:35 +0300 (MSK)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
	t=1795009955; h=from:subject:to:date:message-id;
	bh=iCtO8C76z+v3AVxycrUJkY2p7BT9NCr8k81QRtBpz1Q=;
	b=SXN0dNPvaJza/SewD1pg6Nl5vpU4ouw7bS9V+Nw4bJfY5WSlYNPCLomJc5eCPN6XhKeOhYM9CXO
	Q3pBbTbPO7d8wwuONN2yk67zYP5XB+66fCRu/4yN5GtLVUg/NbGpYWPBNaQFY+U2WhZCbuLzpHwjX
	HhB8CU+TmD6cHBSuroe/moOgbRWBBmURER19hQqXP2xiZPwfuHCVMb6/Uwiuz9toVWtzYR52HSqAO
	wp/u2RpKHxFrbrL1xSBH4pU1co6Ao3pEaklrb1bNwncjatZEjVI/OgKC9D+CbeThXZPLwwtBnDmOS
	GygDFqjO2Lf5Qg9skrqk+h5zpMKYiKEqMGJQ==
Received: from amicon.ru (172.16.2.25) by mail.amicon.lan (192.168.0.59) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Wed, 18 Nov
 2026 16:52:35 +0300
From: Artem Novikov <naa@amicon.ru>
To: <stable@vger.kernel.org>
Subject: Re: [PATCH 5.10 v6 0/5] KVM: x86: Backport shadow MMU GFN and role fixes
Date: Wed, 18 Nov 2026 16:52:27 +0300
Message-ID: <20261118135227.204272-1-naa@amicon.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118134851.203854-1-naa@amicon.ru>
References: <20261118134851.203854-1-naa@amicon.ru>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi,

I sent this series by mistake. Please disregard this copy.
Sorry for the noise.

Artem

