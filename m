Received: from sg-3-112.ptr.tlmpb.com (sg-3-112.ptr.tlmpb.com [101.45.255.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBFF10F1
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 03:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.45.255.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787975211; cv=none; b=ivN5lDEY5LPRak9G5nwmbg/ZM5ofei0QyFQg5XVo1JS2vJ69Vu/MgezvdxABQZ+f20fxmo6/psPp9yJ9jV1sYvlU0DzShmrY7u5J40pv7N+yrY9pIXyRm454LwoFUeiFcQp0KoomLoJoSPvx+RGA+q+3tOkOqtHQZMERczvPhAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787975211; c=relaxed/simple;
	bh=xLGClAwILCuywTlHy+7B36+0AJLSorI01gzy7qmp9Qg=;
	h=From:Subject:To:References:Cc:Message-Id:Mime-Version:In-Reply-To:
	 Date:Content-Type; b=GcKRRGcfq9qrwIVkCvR1crLXJs/um84dV+9C+x70UlRNSGNrXwqCF02ZKL8e+QifsyV50bl7meTzkub5wQhuR8Yfpgd88MJoIAG5bWoZhVU5SVaAmZqoZZTt5KtuNS4YoBi37BAu4I1HKRT5hLwhm4Mdeb1DjAhjqnu4f+5ffM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=S1IVKUOP; arc=none smtp.client-ip=101.45.255.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="S1IVKUOP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1787975158; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=ATP/kUiSwffiaR2fVHyPd7W9IcoS9IWeEorLQ80/wEY=;
 b=S1IVKUOPa+oaX/d8Ymttzq5b6KNPcCZTY1n1A8Hvt2KimyK9VTTRDzdIhq02xKjLX+bVpP
 0Z6RuumjEIjvpQShUBjYUA6lkIY5uWxJmUkxn9OhjaFZxrX0+PXYEOYyESLs6JK8FyCTcM
 IY9PsW+wiDUp3gcKAFHwMHnmt70aQHtgr8dKQi//PbYXH3diQEi11kEwNNPPLGxxNj7lKr
 2lyr/z20PGGlUAO5TTqBxWUiZrFJwUjJYzCheXboxNP65eXuhERwJ1FKvOmCL/EkwmcjBV
 kMEyYx2YCVwZBsAZoJYlzrWMMk7DNF4SclJVskW59JyWUCA+Rlas1j59dm/wbQ==
From: "Rui Qi" <qirui.001@bytedance.com>
Subject: Re: [PATCH] riscv: ftrace: only use pre-function NOPs with call ops
User-Agent: Mozilla Thunderbird
To: <palmer@dabbelt.com>, <pjw@kernel.org>, <aou@eecs.berkeley.edu>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	"Steven Rostedt" <rostedt@goodmis.org>
References: <20260706123554.455065-1-qirui.001@bytedance.com>
Content-Transfer-Encoding: quoted-printable
Cc: <stable@vger.kernel.org>, "Alexandre Ghiti" <alex@ghiti.fr>, 
	"Andy Chiu" <andybnac@gmail.com>, "Puranjay Mohan" <puranjay@kernel.org>, 
	"open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>, 
	"open list" <linux-kernel@vger.kernel.org>, 
	"Mark Rutland" <mark.rutland@arm.com>, <stable@vger.kernel.org>, 
	<linux-trace-kernel@vger.kernel.org>
Message-Id: <0d448a8f-1695-47ab-bf88-fd49b5b20bc3@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20260706123554.455065-1-qirui.001@bytedance.com>
X-Original-From: Rui Qi <qirui.001@bytedance.com>
Date: Sat, 29 Aug 2026 11:45:38 +0800
X-Lms-Return-Path: <lba+26a9255f4+993311+vger.kernel.org+qirui.001@bytedance.com>
Content-Type: text/plain; charset=UTF-8

On 7/6/26 8:35 PM, Rui Qi wrote:
> Commit c217157bcd1d ("riscv: Implement
> HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS") changed CC_FLAGS_FTRACE to use
> -fpatchable-function-entry=3D8,4 or -fpatchable-function-entry=3D4,2
> for all dynamic ftrace builds. That layout makes the compiler place an
> 8-byte area before the function entry, which is used as the per-callsite
> ftrace_ops literal when CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS is enabled.
>=20
> RISC-V can still build with CONFIG_DYNAMIC_FTRACE=3Dy and
> CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS=3Dn, for example when
> CONFIG_CFI_CLANG is enabled because HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
> is selected only when !CFI_CLANG. In that configuration
> ftrace_call_adjust() does not skip the pre-function literal area and
> only returns addr + MCOUNT_AUIPC_SIZE. With the pre-function layout,
> that points into the pre-entry padding instead of the callsite jalr, so
> dynamic ftrace records the wrong patch address.
>=20
> Use the pre-function literal layout only when call ops are enabled.
> Otherwise keep the previous patchable-function-entry counts so the
> recorded address matches ftrace_call_adjust() non-call-ops path.
>=20
> Fixes: c217157bcd1d ("riscv: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS"=
)
> Cc: stable@vger.kernel.org
> Signed-off-by: Rui Qi <qirui.001@bytedance.com>
> ---
>  arch/riscv/Makefile | 8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 3070c3874305..235730a243aa 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -14,11 +14,19 @@ endif
>  ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
>  	LDFLAGS_vmlinux +=3D --no-relax
>  	KBUILD_CPPFLAGS +=3D -DCC_USING_PATCHABLE_FUNCTION_ENTRY
> +ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS),y)
>  ifeq ($(CONFIG_RISCV_ISA_C),y)
>  	CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D8,4
>  else
>  	CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D4,2
>  endif
> +else
> +ifeq ($(CONFIG_RISCV_ISA_C),y)
> +	CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D4
> +else
> +	CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D2
> +endif
> +endif
>  endif
> =20
>  ifeq ($(CONFIG_CMODEL_MEDLOW),y)


Hi,

Gentle ping on this patch. It's been about two months since submission
without any review feedback.

The patch fixes a bug where ftrace_call_adjust() returns the wrong
patch address when CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS is disabled
(e.g., under CONFIG_CFI_CLANG), because the pre-function literal
layout is still used unconditionally.

Adding the ftrace maintainers and mailing list, which were missing
from the original submission =E2=80=94 that likely explains the lack of
response.

Link:
https://lore.kernel.org/r/20260706123554.455065-1-qirui.001@bytedance.com

Thanks,
Rui
