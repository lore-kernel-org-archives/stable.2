Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795541532;
	b=j6MqbRxbxlIUGi0uB/8RVBBGB/X9wwJMGq9oA2zpH/fJAvh1W4AHd3pxx/7wOSy8hiwC
	 q3WrW4ByKPYMZUBuC1B4i6tSmZRmPYF5HsE3mZYROqAtUz6VX9RZUhqAKMw2x0yhxJ6IS
	 Eo6/Oek8krFnhXU2wcdBbNbodcNa1I0KOcNlnVWY9fzm76iqO94x6QliuCA3nG2Sp41rO
	 lqE/kElcAsD8GawPN8CGVbqeMs/OQ+NIhfmfaltvOAtNcgCnWCFTvd6X9Z8Yiw65eEi9i
	 aBxIT71EGlAENpjy1+rmKRGfPfnUzL7NKl5Zm+4P8IG4UP3xGj79ZLcAQrPh0VClKrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541532;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=BTVY4aU3/L8miJpqzvWLyd9xWFkG1Y6BaRFcJkDciFA=;
	b=qNiAjLovHzPyNVlsbftBclLnfe+vj+AzTYvm7jUrC8Ovnoy5l4ShEcOs6OmJr0kO/mX8
	 8MxdbBXHi+JIcxbWD/629P9ZcdnAY/V8uTWo5et7ufeouQ8Ex+WC6j0q6hUUZ9jIvu+Sj
	 EzmUIh1TFV4SwoPaoM61Q0X9rCUY3dBbAMMeT6+kMSkqWhTpRlYhnh+O62iJNfa+QgVWN
	 xkc1EZggkz9fhxIXWsN1955nsRb7mmNttmq1d4Nzdjj1tErvX/QZzz1CAb8oGEbVTv9Ou
	 3Qt2TRv0Swzi4vb8rWp6nrlfxoKmcq4bATccF6XKntX8+bVoqDnZI44cbqcCuNkXFDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=QbzCjmMm;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1F3606A335;
	Tue, 24 Nov 2026 17:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF1F3606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=QbzCjmMm
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42FC9339;
	Tue, 24 Nov 2026 09:32:08 -0800 (PST)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC4F13F763;
	Tue, 24 Nov 2026 09:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795541531; bh=y+ueAXDgxzoT7mF7z9hhxx0rxTk5jOpaLKQ8IkUeO1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QbzCjmMmg7TyLgKT+xUclxK1kp6FLshpTNpBNLnf/txH31j5v82n1H9jT1ZN8Cqk4
	 k0Apd8y126QCGBt6QIwo6PVAveC3op3lmv7p8Kta4VZlDXiSV8enXJVvD13SBAg/Hs
	 M1GcEsgah8M9GWmhbRHZQIf0g70tPUsSnJPRadCQ=
Date: Tue, 24 Nov 2026 17:32:06 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: =?utf-8?B?6buE5Y2O5oiQ?= <1112433017@e.gzhu.edu.cn>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	will <will@kernel.org>, "mark.rutland" <mark.rutland@arm.com>,
	broonie <broonie@kernel.org>,
	"szabolcs.nagy" <szabolcs.nagy@arm.com>,
	"yury.khrustalev" <yury.khrustalev@arm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	stable <stable@vger.kernel.org>
Subject: Re: [PATCH 1/1] arm64: gcs: bind signal GCS restore to the live
 GCSPR_EL0
Message-ID: <awXKFu9PAifaCay5@arm.com>
References: <tencent_122AB752205D1FCC2B359940@qq.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_122AB752205D1FCC2B359940@qq.com>

On Mon, Nov 23, 2026 at 11:56:52PM +0800, 黄华成 wrote:
> Bind the restore to the live, kernel-visible GCSPR_EL0: for every
> legitimate restore at every nesting depth the innermost frame's gcspr
> equals the live GCSPR_EL0 (the handler's return pops its trampoline
> record before rt_sigreturn).  Userspace cannot move the live GCSPR_EL0
> without executing GCS instructions, which are themselves checked.

(that's a pretty malformed patch, missing sign-off, lines not wrapped,
based on an older tree)

Changing GCSPR_EL0 via sigreturn is the intended ABI (see
preserve_gcs_context() and Documentation/arch/arm64/gcs.rst). Any valid
signal cap token is acceptable, including an outer context's token.

The patch would also break handlers that call rt_sigreturn directly,
user-space stack switching and checkpoint/restore.

In conclusion, NAK.

-- 
Catalin
