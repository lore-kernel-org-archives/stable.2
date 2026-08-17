Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9914B049C
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 18:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786992689; cv=none; b=nsDq27QIdMSFdFijg7HH1T0rz+NsMQcQdIgq+QqIL4+h2mmhhzjuNjZqk7g3BJY745kWvkne6lSN5K5rdIQR5paQ3iH+OCWEKZopQEq5fUTNn3eG5+ooAA2JHWUDzUKOoUhMCHXE4KyUb7whvd5pvdw3H4DzUkjZSAwlzjtTXy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786992689; c=relaxed/simple;
	bh=i4s1i0QFcSN/h+ay0HOrwhjO7F/UEd4D1l1k3Kw2yW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ACX98As0ur+XwpWYIKTmqPrY1E7WWqEFfMyFpXFW9JeqvAcNO/lqag0B21bbS8CKs1V7ppNgvDJYY4IDz6ED/X92Os+w1hluo/f98OogROlzbYJp+uO/k18FjRugw46TBRLmTQxGa6c5skPJnSSMoH1cGoDuqlq7KNBvveVXFTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Hysl2UUJ; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Hysl2UUJ"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7ea9c6ea7deso2583132a34.3
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 11:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1786992686; x=1787597486; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NV6AKlYp5eov5B/qzmbk9uBCHMMtP7iabiBirkAkkvQ=;
        b=Hysl2UUJXntbR4bVhLOhjrr5hf9GXdkUFuJxWrnsTZHcs8rkmu3M7TAdKOHiA9vH8+
         hE5HQficBpEBk8zdqNNZFF5I9qwVQCUfeyemkjo1I7+H8fXin2oaPPT4oVMZasIhYt61
         UZyg0AsX6PhWDBCsSp359gZV+v2WOqO5Eo6Y7mdyFberp/O1rmSDhFiYBXAVHQYru6ZR
         N1oGNzEEUsPs84ewIW780LADaQbjc7fFkDTaKKIVUYSR7wF9SwfJXJKErZPLDE06HHeg
         sfACaC38HjNos6FVV3+M1c6KDd3P7yz21YgU4w0htRGFQNuAZ2LosWWjw+a3cfDFBwA4
         V0vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786992686; x=1787597486;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NV6AKlYp5eov5B/qzmbk9uBCHMMtP7iabiBirkAkkvQ=;
        b=Qe2ukbxEpVBslMu27KnDfxN1Ho89UaLBlWGdro6wtB0McV7i4lZK2XtALyr4uSoAOR
         L3JbXENr2joPkkVjKepB83sOv5YZlqMo/UG7k5jYAbnyAypPX/F19uRig7ihbi2P9p9v
         UMm1MVX2XfeiN4X133VcwrF+2YWwy8cl0DUewbXe4cQqEZ+Hs+JCT5/8iA+rFj/Yar0p
         d5fsP6yB5uWBcj0jZMhszXkFmhMXyg2iE4850X1coVbu1OHCa7t66gXeVSPhRjFLU00E
         3CoGf+pPjxpDsDR6PqURbmtf3UfZuQj7nPL/xStyXleE7yPLfrkHtykoLn5BTB864HE5
         eJHw==
X-Forwarded-Encrypted: i=1; AHgh+Ro4hmX69d3+S/RRvv25mdPQX+Msc/dl5QlGtSc+afA08ATBcVooEQgxb3ClrY8rgWtWqFa9o0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm66xZbgRmlxn9g9aB3E9bvj9qaRRP0fD6gyl0j3bwdVLSljR2
	0TWtQ8RChy/hWIO7ETlKB+vVtsEUdJQkWRzxxYYxM6BT1ycboz9wu0pnZblTB9pzVZ4=
X-Gm-Gg: AR+sD11gTwuthuv0sP0d8PeQCER1+lDnUZlWvJQ0+UvUAKqysYnXtKyGjQ+2ddFTPfd
	EbAgKmkj3z7N51f6ndEbt0pvdEq7TBb2HrHXTi0ozCP6zdFBANjzvWbiPWkhnigYMpx2YhkTS53
	4QORIQyGX9uwLNfImFlErzsiZGa4GWwTtPWdiumDRSUguKF58HGgRq8cQtKfgekiVFwGDXtMopz
	TlkRqdRZqDoLJM695uVA7UGw7m8XMFPA2qMRWuYpI3780RUUA0vimQlgGA3DTn78m/5LV5oAPUs
	sFwT0aD7xdVPR1TZZqKSIyI9IpQBNrFGSnZRWagTNfl4LXxR4aS7Shges5kQavNqdPq/t9q81zB
	2/dIvU6D4AxbUh1fx2dNH6KNKouLXrQ7LpSZ7+A5hpTSz2EZbkV047vVY1tmdtc53/IUN4/AM5b
	+ytlIQRYYxnG+DdIlZTr+3ncwQraphEpqfKd+mPscf/S3jR2mFjkp5RYGYkJ08/ZELn6dxQ+Hnu
	530b/Y1dvIYnLjYgkR6
X-Received: by 2002:a05:6830:2708:b0:7e6:f4a3:1df5 with SMTP id 46e09a7af769-7f423bf4619mr2327274a34.1.1786992685605;
        Mon, 17 Aug 2026 11:51:25 -0700 (PDT)
Received: from dev-jrangi.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7f41bef03b9sm2072384a34.3.2026.08.17.11.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 11:51:25 -0700 (PDT)
From: Jasjeet Rangi <jrangi@purestorage.com>
To: bp@alien8.de
Cc: Smita.KoralahalliChannabasappa@amd.com,
	dave.hansen@linux.intel.com,
	dgiani@purestorage.com,
	hpa@zytor.com,
	jrangi@purestorage.com,
	linux-edac@vger.kernel.org,
	mingo@redhat.com,
	msaggi@purestorage.com,
	rhan@purestorage.com,
	rjethwani@purestorage.com,
	stable@vger.kernel.org,
	tglx@kernel.org,
	tony.luck@intel.com,
	x86@kernel.org,
	yazen.ghannam@amd.com
Subject: Re: [PATCH v2 1/2] x86/mce/amd: Fix inverted interrupt enablement during storm handling
Date: Mon, 17 Aug 2026 12:51:08 -0600
Message-ID: <20260817185110.1644857-1-jrangi@purestorage.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260814232446.GDan-jvtKrj4Bh8Nsa@fat_crate.local>
References: <20260814232446.GDan-jvtKrj4Bh8Nsa@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, Aug 14, 2026 at 4:25 PM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Aug 12, 2026 at 04:15:13PM -0600, Jasjeet Rangi wrote:
> > mce_amd_handle_storm() currently does the opposite of what storm
> > handling needs: it enables threshold interrupts when a storm is detected
> > and disables them when the storm subsides.
> >
> > In addition, machine_check_poll() -> clear_bank() -> amd_clear_bank() ->
> > amd_reset_thr_limit() will unconditionally enable threshold interrupts,
> > which undoes storm mode behavior.
>
> Except that the Intel side doesn't touch the CMCI_EN bit in
> cmci_set_threshold(). And we should not diverge here. The thresholding
> interrupt should not be a problem because with increased polling frequency
> during a storm, we should not be really getting thresholding interrupts
> because the polling code will pick up all MCEs that get logged, first.
>
> And the second patch is not really making things better because, well, "on" is
> "in_storm_mode". Basically the same thing. So I'm going to queue the below:
>
> ---
> Author: Jasjeet Rangi <jrangi@purestorage.com>
> Date:   Wed Aug 12 16:15:13 2026 -0600
>
>     x86/MCE/AMD: Fix inverted interrupt enablement during storm handling
>
>     mce_amd_handle_storm() currently does the opposite of what storm
>     handling needs: it enables thresholding interrupts when a storm is
>     detected and disables them when the storm subsides.
>
>     Flip the "on" function argument before passing it to threshold_restart_bank()
>     as it should have been done.
>
>     To clarify: "on" to mce_handle_storm() means, the storm is on now when
>     "on" is true, and off when "on" is false.
>
>       [ bp: Simplify. ]
>
>     Fixes: 5c4663ed1eac ("x86/mce: Handle AMD threshold interrupt storms")
>     Signed-off-by: Jasjeet Rangi <jrangi@purestorage.com>
>     Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
>     Cc: stable@vger.kernel.org
>     Link: https://patch.msgid.link/20260812221514.598842-2-jrangi@purestorage.com
>
> diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
> index f916fb4c5d13..1cc20b855b7e 100644
> --- a/arch/x86/kernel/cpu/mce/amd.c
> +++ b/arch/x86/kernel/cpu/mce/amd.c
> @@ -865,7 +865,7 @@ static void amd_deferred_error_interrupt(void)
>
>  void mce_amd_handle_storm(unsigned int bank, bool on)
>  {
> -       threshold_restart_bank(bank, on);
> +       threshold_restart_bank(bank, !on);
>  }
>
>  static void amd_reset_thr_limit(unsigned int bank)
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

I'm ok with dropping patch 2. But I don't think we should drop the
amd_reset_thr_limit() hunk of patch 1. On AMD if storm conditions are
met, amd_reset_thr_limit() will get called in the same code path as
mce_amd_handle_storm().

```
void machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
{
...
	for (i = 0; i < this_cpu_read(mce_num_banks); i++) {
...
		if (!mca_cfg.cmci_disabled)
			mce_track_storm(m); // <- mce_amd_handle_storm()
...
clear_it:
		clear_bank(m); // <- amd_reset_thr_limit()
	}
```

Inverting `on` in mce_amd_handle_storm() alone is not enough because
clear_bank() will immediately and unconditionally enable the interrupt
again. Also, the threshold is sysfs configurable. For example, if the
threshold is set to 1, even when storm handling is on there will be
effectively no polling.

On Intel the threshold is temporarily set to a very high value because
the goal is to effectively disable interrupts for CEs without disabling
interrupts for certain UEs signaled via CMCI. In older kernels the Intel
driver used to disable the interrupt.
From the current Intel code:
```
/*
 * High threshold to limit CMCI rate during storms. Max supported is
 * 0x7FFF. Use this slightly smaller value so it has a distinctive
 * signature when some asks "Why am I not seeing all corrected errors?"
 * A high threshold is used instead of just disabling CMCI for a
 * bank because both corrected and uncorrected errors may be logged
 * in the same bank and signalled with CMCI. The threshold only applies
 * to corrected errors, so keeping CMCI enabled means that uncorrected
 * errors will still be processed in a timely fashion.
 */
#define CMCI_STORM_THRESHOLD 32749
```
I do not see anything similar for AMD.

Thanks,
Jasjeet
