Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D13503BD8
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 22:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790635161; cv=none; b=LbSREvafxqdseFOGtXA8URTENzLeF9srAKoLJ1WM8zdOdmpNCneHH7odRETJ5CeNAT8VSIBfwNcIFu4ReDI7t0xtd6GfzDKATzAc+ugcgZOsbilBHjY19IiQetrmNnCF74r+8ql+00npTgFvY4YbKHpUny6s9mh5ViIA+DHbJoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790635161; c=relaxed/simple;
	bh=tfQAhhfmgaKqpOTqV41ivoxqzoQ7l4Y0gZiCprBxENo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QeTHlwINcSdwklKWbL5D9kFjYazppM8h5EgoQtQB+9YY5P8Ln2Z7OLwQJrjVyrOSvJ3kPb34CEbYRJ/W85Zx9xkvs3m4YKdJegqUwlSSAwzzxWc52o8ilwINAKDTssnx0Xu9TKpSTvVt3JhcSadYvOtcmhU/qIuHDqfOBEdyRDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOMDur80; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOMDur80"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022B51F0089A;
	Mon, 28 Sep 2026 22:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790635159;
	bh=Y6XbuW4WMRuA+dY5kS218tK5tCYnrlFyrPU3kKFbufQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GOMDur800lQ6e9WOvvVZ/tdbzhfs5mk0gZnuGdXwM+TFYnvKMHzZ9lbTdPW051wDn
	 SiQQ4hkQ5luhTUnJ+P5uBaE74ScfZOTGeVV12nBmGAgaDnkbtqD1J0O/o9MPMGWvrt
	 DKyPLRtqBZvcSJN0gLssCY33wxo/Y0aqx01y1pMfW6uvG8DYI/+L3ED58veYl8wpQA
	 sP4R1KlN1TDjhoa8iuGP7x8ctUwKpwSALDjFffJ1dxDiMUdrOkxNYGiXUYMgy//Gsm
	 BT+tqCgcu/1J8FPQUKROEPGX3D3Ikf4VvvSkMpf1h425k++kewYmeHOuwFgg8uLSrj
	 KJ7mhRh582FpA==
From: Sasha Levin <sashal@kernel.org>
To: lee@kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	sdolan@janestreet.com,
	dave.hansen@intel.com,
	x86@kernel.org,
	Seth Forshee <sforshee@kernel.org>,
	Eric Hagberg <ehagberg@janestreet.com>
Subject: Re: [STABLE v5.15] x86/mm: Fix check/use ordering in switch_mm_irqs_off()
Date: Mon, 28 Sep 2026 18:39:09 -0400
Message-ID: <2026-09-28-2-daily-reply-0005-re-x86-mm-switch-mm-ordering-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928144205.3881537-1-lee@kernel.org>
References: <20260928144205.3881537-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [Lee: The v5.15.y backport of fea4e317f9e7 (12f703811af0) placed the
>       LOADED_MM_SWITCHING write after the tlb_gen read too, so v5.15.y
>       suffers from the same issue.  Applies cleanly]

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
