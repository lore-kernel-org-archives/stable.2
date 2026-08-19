Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A8B3C0603;
	Wed, 19 Aug 2026 03:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787110362; cv=none; b=AuDC5UhYsNfs8mvUG1tYMUZXhoi6QpnaoYu1qNat1DzzwbBJ0bnnPbJrFRBm1Pn1dMsTxr7KBNpG4VOLA21tVi/XLeOZsyHO/yJIMPqyUWwvKhLir8b77gq/Z9Huj+97280saupIF1UUdOuYWqagL/etEvr4Mn/qyVkiyGTQGIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787110362; c=relaxed/simple;
	bh=DRRMksPOiy8VxntO3NE2+/BU8TDIxXf6P1aHfOCse/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYcW/ifuDN8ZSR6DqdkeHjTAbxbk96JUDpc9XxZRsEYNats/2H4O8hLe1DOokp16TswAfevcxzJVK9R1klKFr2cfYA82F32cpgOhEjXZ4H4SnPVaxbATVIgyRiMl1cOwR1Q8wbZMAygJR2WMpvIBQ/1wlt5K7tqifQb6s7u3bqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IjGLVxC1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IjGLVxC1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D348A1F00A3A;
	Wed, 19 Aug 2026 03:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787110360;
	bh=RiO6nRyKaGYmjg+34S9Vf5gENfCuW58pMcX1iAk9eN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IjGLVxC1a81rwsj3b62g+MZV8vcxtkY8V+fMP7/J62XGYTiiwbU2iu6W7CSRpypXX
	 TohKV7Wf6ztqrA506flHOAtenJH6QUZ1D832pf7z/9OXlrfxg0r7Zg6SGw2AtXRLTZ
	 Uh2DG2L6AY+glqV8Kk4yMV97OxZgYsuuAvpb/nWb1Eb0Kbp8j68qfXrTi/1OYmBwri
	 nCknIuP3Iq3dzy3dr9Ls4WfWOgsIugEzdbsuqKfwmxUVFoiWpP55DxHA0plG4i6qN3
	 inFdnDQ/FR4K/3LZJmA2Hc05iVfCnRPLyh2kmGIp7O4SNdlTvxkyqZD9kMMkT+f1pJ
	 l7D0eMC8Neayw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	Cheng Ming Lin <chengminglin@mxic.com.tw>,
	Liyuan Pang <pangliyuan1@huawei.com>
Subject: Re: [PATCH 0/2] Backport fixes for UBI
Date: Tue, 18 Aug 2026 23:32:22 -0400
Message-ID: <20260818220420.8@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818-ubi-backports-v1-0-324d6816d2ae@atmark-techno.com>
References: <20260818-ubi-backports-v1-0-324d6816d2ae@atmark-techno.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Aug 18, 2026 at 02:09:33AM +0000, Dominique Martinet wrote:
> While looking at recent UBI patches I found these two commits that I
> believe are worth backporting.

Queued for 6.18 and 6.12, thanks - 6.18 is missing both as well, so it
gets them first.

-- 
Thanks,
Sasha
