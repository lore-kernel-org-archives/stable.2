Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB8F199E89
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 04:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783916656; cv=none; b=Og43XnewhHVDXRzH02cPJT0nTISAsdJrIrb/kT4gfTwy6lW6cp+S29Nvkt5qeVTl67qFb+oMjx6WIoty2dmrWtXOcWxIm+5AtCFxMU/AHeiK4NpnM2tw4dEqKugTuyPQHlpkGFHWcjCh/dxK1py+1L8/nY+1ZTrMKtzY3xpfZKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783916656; c=relaxed/simple;
	bh=/D2a7BNUdsqQJ6AuXAED6drETKIR3KCHC7TwbSWU77o=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=awc2fzC592X9YBUSxfGROzIHA6xhr90PeDb3gF9X1mFLsg2MqsAX04+YoymirDvoE+z6Nt0hkqnGpL+YundvLh2r+GAx9q645kUZpA9CMaxoK4ZwecFAoZU7LVnKD8I+nROBgdlbfP468nkMcDJMLNW32Yf3GapfL96yIyYs+ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZ6wwqKV; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZ6wwqKV"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c9d1fff21edso1472433a12.1
        for <stable@vger.kernel.org>; Sun, 12 Jul 2026 21:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783916654; x=1784521454; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=C58B2cKbjinGkAAF6rks5KVUbvwkNc4eqillvWc3cV4=;
        b=HZ6wwqKVNDYgUZ2vge2DY456dC/MJHOXEnksitevvDKqzaGS9jTTqcqTxRYDOFzTnN
         D2O/ZjW2Sc8CJJdZPJkFg/xuP9U6tJCJug7bCExMdFiyiTv50nYa1EHSB/IaqCR3Vi2H
         tK09asdryLs9nCuOLQQhSOHs+2LHbOo3LW8yHrSO6vp5PI6OIGQl3kNCzr2tJAYFuYrC
         KO6vXjPsOAEimy9OGjr5DHR3EGdKR2NKh7mOsMO8Ihlg1mxF+1u+M/8kJRY/dE/Lxy00
         nyc2PgLNRIsDwQIIsLwo44/PwK+DhsqfLr7z5Q4a1dBWfBchr5/zAIJDP9R+cjuOqaKv
         mvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783916654; x=1784521454;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C58B2cKbjinGkAAF6rks5KVUbvwkNc4eqillvWc3cV4=;
        b=Hl7nYDYfJuRpDlH3L5qBdkiQKbvlS6BPi/jDyAbl2HsSKo6hw0d1uYBrWtuoLOe8j2
         8Cm3SGRKbHc32p3zXn1r2eeYu3RwQ6u4abg3AY1tchNnoDzQEOvosryMXGJNl0Oqn0EA
         MesrAobUc+ofwhYczeqWnwTIeqFMPpCSIYccOP+j6G894/JzVEDdXDb8HOMdNSF3qGpq
         sHyB5aQTZkoF7feozyuOZ00OQcmqZVlmduCs/j863keJXtn25HEMvqjNhciu6a0AgTsS
         rvKSAmAk2LjCu6AOQoAZesJA3oaL30smuEEwpiasAbRsKCp83At/ewqeVu+qrNdb3Ooz
         InLg==
X-Forwarded-Encrypted: i=1; AHgh+Ro48oxC1QWjfbafE9TT3OKCEWZA1E/93fT4q75ndC+gSL1dEk2aYH+JjR6RSsecAmC7lTDurng=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBHzAgcd1zDzCawFEwbFIolOsJjK53QYJknXKPgxeN2qDZxMYO
	t6M3DVL6v1WsgfRlMDn6hfMBxh+hDaiGd6lusBp9ocEX/EtZgOu39/Hu
X-Gm-Gg: AfdE7cnkxN/a+SLeLrmVE7XuHufA04ZlUqnLVceSUBflod+cbGupYQPbHlYHZZo8joh
	kqkBVi0DyOtCSQsqA50hmCO4pQypsCV6aJLsV67e/EgdUrFasx8YSomlUFHAw5FlengsxNqad0r
	Um4nUwJj9koXJJNulE2OfgAAPxmgRXlQXgIzU4skL0mhWUZRb9XlDh+NDQikH1rWju+JTKKSVIr
	rnmokHc+9mAW0WfA6jOdGH770Qg04imBoenVr/dQZQ1K1AJbDBO3OesdJLaSGNwDd1PA3JgK/Hw
	Ki0qe3IKCb9+X9kUjD921EVMFfP6+d218a6J3JvX6iAqWbQ6iWeEBMJMfVro1QaZ1VS4XzqP1iO
	eOvk7DHwnQ7roEW7bmTTPKut3C/h3EhX/mVQ0vZaM2YaKaTJGrvn8QnYvE+q4PnD1P43/IoN46a
	5JxcBXHLbI2Ug=
X-Received: by 2002:a05:6a20:e292:b0:3bf:e449:3316 with SMTP id adf61e73a8af0-3c110a17884mr7791913637.14.1783916654109;
        Sun, 12 Jul 2026 21:24:14 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b987fc629sm14773232c88.0.2026.07.12.21.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 21:24:13 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au
Cc: npiggin@gmail.com, chleroy@kernel.org, shivangu@linux.ibm.com, hbathini@linux.ibm.com, mahesh@linux.ibm.com, adityag@linux.ibm.com, venkat88@linux.ibm.com, stable@vger.kernel.org, Sourabh Jain <sourabhjain@linux.ibm.com>
Subject: Re: [PATCH v2 1/3] powerpc/pseries: Move H_WATCHDOG definitions to a common header
In-Reply-To: <20260713035954.1559605-2-sourabhjain@linux.ibm.com>
Date: Mon, 13 Jul 2026 09:48:57 +0530
Message-ID: <se5nv7wu.ritesh.list@gmail.com>
References: <20260713035954.1559605-1-sourabhjain@linux.ibm.com> <20260713035954.1559605-2-sourabhjain@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Sourabh Jain <sourabhjain@linux.ibm.com> writes:

> The H_WATCHDOG input and output definitions are currently local to the
> pseries watchdog driver. The next patch in this series also needs these
> definitions to issue H_WATCHDOG hypercalls outside the watchdog driver.
>
> Move the H_WATCHDOG definitions to a new common header,
> asm/papr-watchdog.h, so they can be shared without duplicating the
> PAPR watchdog definitions.
>
> No functional changes.
>
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/papr-watchdog.h | 58 ++++++++++++++++++++++++
>  drivers/watchdog/pseries-wdt.c           | 53 +---------------------
>  2 files changed, 59 insertions(+), 52 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/papr-watchdog.h
>
> diff --git a/arch/powerpc/include/asm/papr-watchdog.h b/arch/powerpc/include/asm/papr-watchdog.h
> new file mode 100644
> index 000000000000..fb3a511aa861
> --- /dev/null
> +++ b/arch/powerpc/include/asm/papr-watchdog.h
> @@ -0,0 +1,58 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef _ASM_POWERPC_CRASHDUMP_PPC64_H
> +#define _ASM_POWERPC_CRASHDUMP_PPC64_H

should be _ASM_POWERPC_PAPR_WATCHDOG_H

> +
> +/*
> + * H_WATCHDOG Input
> + *
> + * R4: "flags":
> + *
> + *         Bits 48-55: "operation"
> + */
> +#define PSERIES_WDTF_OP_START	0x100UL		/* start timer */
> +#define PSERIES_WDTF_OP_STOP	0x200UL		/* stop timer */
> +#define PSERIES_WDTF_OP_QUERY	0x300UL		/* query timer capabilities */
> +
> +/*
> + *         Bits 56-63: "timeoutAction" (for "Start Watchdog" only)
> + */
> +#define PSERIES_WDTF_ACTION_HARD_POWEROFF	0x1UL	/* poweroff */
> +#define PSERIES_WDTF_ACTION_HARD_RESTART	0x2UL	/* restart */
> +#define PSERIES_WDTF_ACTION_DUMP_RESTART	0x3UL	/* dump + restart */
> +
> +/*
> + * H_WATCHDOG Output
> + *
> + * R3: Return code
> + *
> + *     H_SUCCESS    The operation completed.
> + *
> + *     H_BUSY	    The hypervisor is too busy; retry the operation.
> + *
> + *     H_PARAMETER  The given "flags" are somehow invalid.  Either the
> + *                  "operation" or "timeoutAction" is invalid, or a
> + *                  reserved bit is set.
> + *
> + *     H_P2         The given "watchdogNumber" is zero or exceeds the
> + *                  supported maximum value.
> + *
> + *     H_P3         The given "timeoutInMs" is below the supported
> + *                  minimum value.
> + *
> + *     H_NOOP       The given "watchdogNumber" is already stopped.
> + *
> + *     H_HARDWARE   The operation failed for ineffable reasons.
> + *
> + *     H_FUNCTION   The H_WATCHDOG hypercall is not supported by this
> + *                  hypervisor.
> + *
> + * R4:
> + *
> + * - For the "Query Watchdog Capabilities" operation, a 64-bit
> + *   structure:
> + */
> +#define PSERIES_WDTQ_MIN_TIMEOUT(cap)	(((cap) >> 48) & 0xffff)
> +#define PSERIES_WDTQ_MAX_NUMBER(cap)	(((cap) >> 32) & 0xffff)
> +
> +#endif /* _ASM_POWERPC_CRASHDUMP_PPC64_H */

ditto

-ritesh
