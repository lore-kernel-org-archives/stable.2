Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793819062;
	b=jOCNxr8xpt3PPXV2YRD7DqNhDqwFutJpBMLNnk4Sxsdp/WIrFGXfiKbpy9ud91vovl3z
	 sKDJnW67Y8XSJj9be3jfdQVEErveTP8Fy62FR56oC8aB2YfF41MDOmeYw7pSmWEaJobXo
	 j7RVj3xMLuwLrLmkbDRfC5pJXIrFUjowlOVAURshxd1mg7PTtiTY5uAxLTucd/BHHBNt4
	 3bdvXPI2rvE2gMxpT5+RZkQj42DZAchmJFxw0CzkrGPxHiD9dXV1crryRz8oJbdYFTgI0
	 fzJ2tKZnpwWNf4DXkWzDbHwZ/jebXQm0G8sE8RS+2P2umY0KMqhLUNLfX5txLhqDw1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793819062;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=ZcNOKAF+btuKJx3uZSf5CmZcmaTrqP39Exdfb20KUT8=;
	b=ha4cu5uh5TB6eCuC/o0/R/2z1ZofwlwctrhuMuRethyz3KxWN924djDgZNHN5XuLILWs
	 U1NHntTxMxRzLK2IVyqG4HnbD9M/JTK5IDRaAn2ASVAlPE+1L4jFX0RUyLD3R3aos3aUk
	 GXlGaZnQiszRdqUd2uL6t8LjRyvAMquTi7L7d68jKFu0vjWBkoiDBTPd24nkQsEsAlIVi
	 xRjcGpmyDqByTs870c3eR2Gg2H+hA2N2oA1EaK5M2vKwZ3pnvvd2uKVcF23yqq8D2iI0C
	 nNhsINvSW9IFbArXslbDx4XawGQXS9nYdhOsAbiHNve0SojqIjhZ83kLFDn2ieGrnvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=grj8sXve;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D380C606D817;
	Wed,  4 Nov 2026 19:04:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D380C606D817
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=grj8sXve
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F18351650;
	Wed,  4 Nov 2026 11:04:17 -0800 (PST)
Received: from gaia.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 595593F673;
	Wed,  4 Nov 2026 11:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793819061; bh=e2/cEutB6rP6H6O7LKfGlCjcwtFZrdduOluWtjmZmwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=grj8sXve4ropMy7ygQPr2l6wjWitIEPyVLFfoW9Tu3DIk8YJl/gFHn2IoMuw8iKVj
	 87zso7OeaDaUNTYLa+241oL835Zu/mTCsfAql26dP0WpCynBURr3nSRGfqU9MWLZK4
	 lEB7Jvb8UpNbLv4Is68eGeg7Blz86t2SaSvT7+ck=
From: Catalin Marinas <catalin.marinas@arm.com>
To: will@kernel.org,
	Wei Wang <wvw@google.com>
Cc: broonie@kernel.org,
	mark.rutland@arm.com,
	rafael@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	wei.vince.wang@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: suspend: Save and restore TPIDR2_EL0 across CPU suspend
Date: Wed,  4 Nov 2026 19:04:11 +0000
Message-ID: <179381905166.1379866.18383747064499399879.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261103175941.1349818-1-wvw@google.com>
References: <20261103175941.1349818-1-wvw@google.com>
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
Content-Transfer-Encoding: 8bit

On Tue, 03 Nov 2026 17:59:41 +0000, Wei Wang wrote:
> TPIDR2_EL0 is a live EL0 register on systems with SME, but
> cpu_do_suspend()/cpu_do_resume() don't preserve it. Its value is
> UNKNOWN after a warm reset, so the task that initiates suspend can
> return to userspace with a corrupted TPIDR2_EL0.
> 
> Save and restore it alongside TPIDR_EL0 and TPIDRRO_EL0. The new slot
> fits in existing padding, so sizeof(struct cpu_suspend_ctx) is
> unchanged.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: suspend: Save and restore TPIDR2_EL0 across CPU suspend
      https://git.kernel.org/arm64/c/beeec0404622
