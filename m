Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344404;
	b=mHAs+RgwwbHJ6kqrf8UTrHhqtONmPzt2eeWv4aV8ppmVzGAcZR5q29h0qeQo1gcTY6y0
	 mlSWV0tzAwrlI4KdfvnGCteHlr/STIIvjPryc0TTLmEP2K5iBUedKSBCaZ0TRlkuhFLIo
	 Hagb63LuEF+akk79lRl6YLNbVqBOXH5155QDn65peVOxLtQAUfdsEzWnQ8Lh7XSkj6x8C
	 Nqb8i0179l+pbbn3zxqnZ0dbLxoRebgg+NFCetvQ51j7JIOQPWRbJW6XFsUhLga/clnD8
	 GTiQStB17Fb2e8ZfhhJY8729WaptlyS7Zx2ePsfTNPFAPy5wC1dzGZll56swqZgfiVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344404;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BDS7W9ulAS/1Gj227DrKULApYUROJJB1GeY+nqeylKU=;
	b=pBg46FJFr0Ng8IrpZlHuG7RiQIShK0SNwPxE6gk/n5rr7hBqNSt8U9gY66hgHXPydSzh
	 gykWXumaDO5f1qe+lN6+uzfV5jkcnkPSc68JiX9vtZS5gbIc10GM07YyUSgFiVqZU0vqf
	 7JvVhe1YU3SczAsfxU8GXlhetSyxkLlnFbPxLL25UIeOZjGIeLwknOmTLPZn9q+m0JkCY
	 zcjrQbTjyHoq7hLyQFn12qKs8XBtVq9yPZ1Ciwcxj+oWil2tnDXQGUQxn3SRnkLr/icLz
	 F6KGs4SVkb/SRY/eAM6jJ3pwI91YGT0jIwUWWweVG7DvQyS7l+5duMp/PLodNhG4j4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zh4qRyDL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632B8606A336
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zh4qRyDL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1C41F0089F;
	Tue, 10 Nov 2026 21:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344404;
	bh=BDS7W9ulAS/1Gj227DrKULApYUROJJB1GeY+nqeylKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zh4qRyDLOiea/924F3r+EzP3feu5KTA1tOq6LI5B1anyGyPIE2Vn2kSL8lWwsOR/Y
	 Z2b3O3zHr2sXfD6YUbBAJv7xWYQOjg85P8Gt4qycJuOfdqvp4uQ+zUQ9ScasS6epEL
	 qwQVgN66DDNrYF8dRdR5aFwgnEsB4Nh/B5UWv8xRrZt97+Rd/gvSgBbxTYlB0GokYd
	 07SzAkfygUpYXqhh9MuP46rr6PL+I46n6sPDtSDQWjmtQW2wovA8CQbWYBXW9htBaw
	 7fnA7F256GRA7fvk4939oI0ZbORtQmu0Gln+KeiS+oH9hXojafrFZolcorVv63IopX
	 RuU4w2IXVSo1g==
From: Sasha Levin <sashal@kernel.org>
To: iav@iav.lv
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Thomas Gleixner <tglx@kernel.org>
Subject: Re: [PATCH v2 6.6.y, 6.1.y, 5.15.y, 5.10.y] genirq/kexec: Do not take the bus lock of an interrupt chip on the crash path
Date: Tue, 10 Nov 2026 15:59:28 -0500
Message-ID: <2026-11-10-1-daily-reply-0032-genirq-kexec@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <87eccuuhvt.ffs@fw13>
References: <87eccuuhvt.ffs@fw13>
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

> genirq/kexec: Do not take the bus lock of an interrupt chip on the crash path

Queued for 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
