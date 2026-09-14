Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2ABF38F230;
	Mon, 14 Sep 2026 23:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789429413; cv=none; b=nwkOFQFV+X0QKKfH2JdOUe+JfFQAA0E9Jz1+bioPuXQrgH6DfbWM4VugN2MTMaooK847HKSHB8ikPyZbDoDI7AjTOH3utwaousr5V2TFuJLlF268K655TSevdQTuaBsfHPbt6A12r+HxUkpgk28BokhBIhKGm97DzlNqxsK8CPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789429413; c=relaxed/simple;
	bh=AkOEYmEjjxT85nJ1LSWabphz0KmT/Dcdx6Y43dows3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZUAY10N6R5pDhswbstu+VBBCtwRTE/bIE+3kWiqCVaR5CX2MuoiPDokobIOmyZ4BDFppQF+ljiitKcxIpRsCU5ySgP59nXF6ZK4MIv0zwa1OujKfkEISPKpU0vv0kGS3xSLculA+msJmVzmOj92W2GJZsTlzWVfV0jf/l09tM3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ist19+WF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ist19+WF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5232F1F000FF;
	Mon, 14 Sep 2026 23:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789429411;
	bh=1xTm6AVOIfnX7bAFeKqrNGc9d6PmTF1RnXhgKSLcSJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ist19+WFhIzMzn5+dTfVRB2JDnLwCfciuducJZc6CTmfoKdL6plAT9Tj4Li6Uzz2g
	 cSIfZQEXVhuRqpx9J8fTvGoXNNWeDfRARjrps5X874sF2xG4karu0InDdM/SI/t/X0
	 CqobaAdoNIsyK1hnDB2USmE5veeSMXImjGPXuSBl/DHN8ahIBgjqrJ7KdaC9RPi70w
	 fj0DsTUCBHuaxl9mtvLWARQF9GSm6id0I2uzGCHFeO+CYiq4Mo9HIITqiTBNJJFljm
	 Uws+Oo9FnpBB+NCBav7CbNe/LCRqrFlIxw6qnALQ3dp/FpuuSWYBcjac4jY7ZQYdz5
	 P5DZQR74lci2g==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Usama Arif <usamaarif642@gmail.com>,
	damon@lists.linux.dev,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 0/8] mm/damon: move damos filter range arguments validation to core
Date: Mon, 14 Sep 2026 16:43:23 -0700
Message-ID: <20260914234324.100142-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260914142327.92510-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 14 Sep 2026 07:23:17 -0700 SJ Park <sj@kernel.org> wrote:

> DAMOS filter range arguments are being validated in the DAMON sysfs
> interface.  Some of those have minor time-of-check to time-of-use
> (TOCTOU) bugs.  In future, other callers might have duplicated
> validations with similar bugs.
> 
> Fix the bugs and further refactor the code to move the validation to the
> core layer.  Also add kunit test cases for the validations.

Sashiko found no blocker for this series.  Sashiko send its findings to damon@
mailing list [1], and I reply those if anything needs to be clarified.  Please
refer to those for details.

[1] https://lore.kernel.org/damon/


Thanks,
SJ

[...]
