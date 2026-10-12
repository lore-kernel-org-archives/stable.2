Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B4749CF2A
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818799; cv=none; b=bI9bbA/6kH53wOMVDHBv3ZYXLbx0VeMfne+QhvSDp/yodkF8TWiwHpA7G6abk/2K3czL2JktY2BF0j4YAkZDXxgbkGKoyVVD5IMU5knLoXIYQHsMWRI9boQcfmmkqhQRQPgy08NkeyQPQBcqTMXQztKO+ZjmFLdueqtObfhe2/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818799; c=relaxed/simple;
	bh=U864yFzTOzCb1kJgLXsdxYqGkzqdvjflzKmJMkq3yZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uocHmQyxuAc1afMqrtbCpYMSlkITFJTl1id1/IJBoVU1luFQvSblpfIYVNgx4gOq30+NujVRt6Gn56aFv8rX3+zEqdxCe62dIWKOZoII0eKfXTmMFpZXWaz8sIuFmuCXTR45eP2b++dZJo2qR5Ht30ItcHrhoClwLsuZ4osrmXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtErWZhu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtErWZhu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AFB1F0089D
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791818797;
	bh=cIf7zymaan5CSKxf/DjyAVBgAoSRW75yynnFxHDngzA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=gtErWZhuz+Al87MVGW9IBaaBKQBCMeAm+tWcH91ZcSS/ECSDRR8WvzWidAPVGpnQh
	 La1tqoxlGTTYWg3r6rWFhRwG8qTZ3hdUDFRD42HJGXTvaQ1/L7AgXO9uEHCEChcaDW
	 lRh+1TZM8yv3ytVwtkZy1RRHV1tFMJB17Pdqe8TLQdp7O8BmwsQz/6OxQBwW9jRyTw
	 TyClsnOtAa0N56NkcISqLclJICRIkNHIue7v0BzNNncI7vHb7RpySQ9weGF3i/OY7N
	 iw0iMz7UakraTLqjy8tVkDS6TsYwAgg2BqIBOyeZda/RT267MaBoE6lIiyyOh5sXzZ
	 Pt5x6L6dQSCyg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5ba3ec92031so2030564e87.2
        for <stable@vger.kernel.org>; Mon, 12 Oct 2026 08:26:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwr2/ta8/PxmYDFeeXPAaEBeMwKI8VBAVulglTIFCqqxzMACzmJh5ezotMaRPUO5hslnLllS94=@vger.kernel.org
X-Gm-Message-State: AFq9FYLs02DLhdghz7mbOCmR64gGepTYPLniHhdekLLYQ/Kk5284/k9h
	i2rnbgEKtdf3BgrceGVKRmbX/II7CPdoR31KS649lKNqhCEX2bXptUQ1uOPxkfmOVgu/+0qs1cu
	jAKTuSTaJRikSUs8xHg9Ex4Lcno6JTcw=
X-Received: by 2002:a05:6512:3e20:b0:5b8:b419:b7b with SMTP id
 2adb3069b0e04-5bcde6ad522mr3321549e87.49.1791818795934; Mon, 12 Oct 2026
 08:26:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925-ghes-queued-accumulate-v1-1-df50553957d4@debian.org> <56179353-7e02-40bc-b443-80ab8e6b627d@linux.alibaba.com>
In-Reply-To: <56179353-7e02-40bc-b443-80ab8e6b627d@linux.alibaba.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 12 Oct 2026 17:24:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jj0xxNo1V478yEUQNRNqGNH_63_x4h55tvgoaJe2Efug@mail.gmail.com>
X-Gm-Features: AclHuK-xTYsyTmE-qiICl-bXlfsPI5BfK6YWXZYZCnzTzhabJ_eN3RxEEc8ueLg
Message-ID: <CAJZ5v0jj0xxNo1V478yEUQNRNqGNH_63_x4h55tvgoaJe2Efug@mail.gmail.com>
Subject: Re: [PATCH] ACPI: APEI: accumulate the queued flag across error sections
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: Breno Leitao <leitao@debian.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>, 
	Xiaofei Tan <tanxiaofei@huawei.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kernel-team@meta.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 3:59=E2=80=AFAM Shuai Xue <xueshuai@linux.alibaba.c=
om> wrote:
>
>
>
> On 9/25/26 11:09 PM, Breno Leitao wrote:
> > ghes_do_proc() walks every error section of a CPER record, and
> > ghes_handle_arm_hw_error() walks every error-info entry of an ARM
> > processor section.  Both assign to "queued" instead of OR-ing into it,
> > so only the last iteration counts: a later section or entry that queues
> > no memory-failure work clears the flag an earlier one set.
> >
> > Instead of reassigning the variable at every time, just do an `OR`, so,
> > if there was a single match, it will return "queued" as set.
> >
> > The comment above the check says "If no memory failure
> > work is queued", which is the semantics this patch implements. I.e, onl=
y
> > SIGBUS if there are queue was not handled at all. If we want to SIGBUS
> > if any event was not handled/queued at all, we will need something more
> > sophisticated.
> >
> > Fixes: 7f17b4a121d0 ("ACPI: APEI: Kick the memory_failure() queue for s=
ynchronous errors")
> > Fixes: ccb5ecdc2dde ("ACPI: APEI: fix synchronous external aborts in us=
er-mode")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > ---
> >   drivers/acpi/apei/ghes.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > index fe10ab0e02f68..ec2d5ca51db02 100644
> > --- a/drivers/acpi/apei/ghes.c
> > +++ b/drivers/acpi/apei/ghes.c
> > @@ -603,7 +603,7 @@ static bool ghes_handle_arm_hw_error(struct acpi_he=
st_generic_data *gdata,
> >                * and don't filter out 'corrected' error here.
> >                */
> >               if (is_cache && has_pa) {
> > -                     queued =3D ghes_do_memory_failure(err_info->physi=
cal_fault_addr, flags);
> > +                     queued |=3D ghes_do_memory_failure(err_info->phys=
ical_fault_addr, flags);
> >                       p +=3D err_info->length;
> >                       continue;
> >               }
> > @@ -951,11 +951,11 @@ static void ghes_do_proc(struct ghes *ghes,
> >                       atomic_notifier_call_chain(&ghes_report_chain, se=
v, mem_err);
> >
> >                       arch_apei_report_mem_error(sev, mem_err);
> > -                     queued =3D ghes_handle_memory_failure(gdata, sev,=
 sync);
> > +                     queued |=3D ghes_handle_memory_failure(gdata, sev=
, sync);
> >               } else if (guid_equal(sec_type, &CPER_SEC_PCIE)) {
> >                       ghes_handle_aer(gdata);
> >               } else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
> > -                     queued =3D ghes_handle_arm_hw_error(gdata, sev, s=
ync);
> > +                     queued |=3D ghes_handle_arm_hw_error(gdata, sev, =
sync);
> >               } else if (guid_equal(sec_type, &CPER_SEC_CXL_PROT_ERR)) =
{
> >                       struct cxl_cper_sec_prot_err *prot_err =3D acpi_h=
est_get_payload(gdata);
> >
> >
> > ---
> > base-commit: 587858367581b9c55c3690f4e63382ad622719d4
> > change-id: 20260925-ghes-queued-accumulate-591c8ac3b32d
> >
> > Best regards,
> > --
> > Breno Leitao <leitao@debian.org>
>
> Good catch, thanks for the fix.
>
> Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Applied as 7.4 material, thanks!
