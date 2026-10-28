Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202783;
	b=FQZNNF72D+6I+kSAJKHveXXWEJMTC40lI48uhHMC3UQUx6a8DXqOe2hodNbZ3uWTqG6k
	 wUSldHqaEu7ULJxmHVvtdmpSWqfsTWrF4aDxwjEl50YFJlDXKzk4rCWMgExjVxSgDGOUX
	 /+pQjzN7mLfXAwNcAPs5MUKTDdas8qROs+OZFWfGHBE8ztGt4JbN+g0afy31ORGC6I3pf
	 qX97jborUu+MWollhvGl+NHF1fpV2KiD3dDuu+J8ZhqY0HWLil4FIgtse1ywOKzb0Utrz
	 uWP3WA0pWBCr4trvuykoyRtYP92bEuoTyZSdx2LEwDPLtL82xcH/qJ4L1F6PPYDlX4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202783;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=k7/WFQgI1klt8knDT67c4NlMWlGHShn8Yjg46gYmNDw=;
	b=zEf2FIGaj+ehQZG0SJhWuht46m67lNc7VtvIGHOtQ3I5uiQl2SKLkWYXHaxrhToaJiKo
	 vGZLcBRoVhrHDhUxkGsDfBDnomrvVPn85UZEL5VkrLutLbUjnRrOS6w6gH307JhIBE/4v
	 rOIbf+YSULiYUPmnAp6i5N2lAdxEqx5TaRhwuwtwEFQ4AwkqapX1dvc9wkgu3vB7TrRCG
	 /l1yVOyYl7PH35HpxTqB6zSTEHXjwxxCZjCKiBbGVL2MreBnMrJHr4DDKpM9EkJw56WUT
	 OG4j60edLuufugFdRET8GvycczOLGY4sPmQ/vwSDawmFHokaXTbem77IdpPAHzn4btg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=erX1EmWb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643F8606A321
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 15:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=erX1EmWb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E64791F01825
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 15:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793202783;
	bh=k7/WFQgI1klt8knDT67c4NlMWlGHShn8Yjg46gYmNDw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=erX1EmWbLDv/TBzOz7qi69qbpJmkYEmfPBMT6n337TZpOdkbcLC3iMqSgLeflb0tO
	 bAVmdLJsMnurdix/zGACsmkDXNkGxsP24mIHsaG1WqNAuOWMM5JRcKRX6cgnLkKBO1
	 KhQbDizNlLaH+XTa4jZCLvNOPhIYLUM8LbhjW8K+C9QT+uchGEL9NQQQgg3z0i3C3z
	 7vBK/o4KPQOiPb01AaBMHuQm1BWpJMtmvmeaXtS4Zzr67bx4PD6MaUTZhSd6nghvPN
	 eb4s6BhzK4iGYE1S/j7HKD2pkMWmAqr6LjKJyHZS5zekxTZKFY1DN0KwZa879a0mLf
	 i0FZ9wO7EMo/g==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5bcb440d1cbso987233e87.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 08:53:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzwdkisfb5siir8EFszBnUGLlXKQqAoqTc0Lnqwi9d0Zndn3BYH1ng73iv9R5RUlDZjv67nuqM=@vger.kernel.org
X-Gm-Message-State: AFq9FYL6PZxaDbDMuy1HZzarHQRRFehdqq/JQ4We/QBfqCdzCgb4QACq
	DUDXgRErNo7tDlBBh6YgskfmJsFi8id3yz4MFkaRed+RSRCbwpq85DGyYoKk4J+YBrCVT6yWGXP
	hYZPQsl0MPr7tvxyhJbquwDETsf3tJX0=
X-Received: by 2002:a05:6512:239d:b0:5bc:db13:36c2 with SMTP id
 2adb3069b0e04-5bfce242b44mr820163e87.21.1793202781347; Wed, 28 Oct 2026
 08:53:01 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAJZ5v0gVkYuZAh7H8KFakN+vHkJTjzvmZsLrUVP0MXkaKLVoCA@mail.gmail.com>
 <20261028094659.2321491-1-zakbrightonknight@gmail.com>
In-Reply-To: <20261028094659.2321491-1-zakbrightonknight@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 28 Oct 2026 16:52:48 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hT6aoX4tuJM+rO_5iequFc_7rEXCoaFnHoJBaH3JP4KA@mail.gmail.com>
X-Gm-Features: AclHuK8aNoe9kkYAGuDSvO3tOIA4pVsJrn2Ir7IDfeuQDnFy6yyqcTeZIXzeJH8
Message-ID: <CAJZ5v0hT6aoX4tuJM+rO_5iequFc_7rEXCoaFnHoJBaH3JP4KA@mail.gmail.com>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Restore P-state request on
 resume without HWP
To: Zak Brighton Knight <zakbrightonknight@gmail.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Doug Smythies <dsmythies@telus.net>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000cb01f9065ee88e42"

--000000000000cb01f9065ee88e42
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 10:48=E2=80=AFAM Zak Brighton Knight
<zakbrightonknight@gmail.com> wrote:
>
> On a ThinkPad T520 with an i7-3840QM (Ivy Bridge) running coreboot,
> the CPUs stop using turbo after every suspend to RAM when intel_pstate
> is in passive mode with the performance governor: they stay at the
> 2.8 GHz base frequency instead of boosting up to 3.8 GHz, until the
> policy limits change or the system is rebooted.
>
> During resume, the platform firmware sets each CPU's P-state request
> register, MSR_IA32_PERF_CTL, to the base ratio (28).  Without
> hardware-managed P-states (HWP), nothing in the passive mode writes it
> again afterwards:
>
>  - When the nonboot CPUs go offline during suspend,
>    intel_cpufreq_cpu_offline() bails out because cpu->suspended is
>    set, so the cached P-state (cpu->pstate.current_pstate) and
>    policy->cur keep the values from before suspend.
>
>  - When they come back online, cpufreq_set_policy() does not start the
>    governor, because cpufreq_suspended is still set at that point.
>
>  - cpufreq_resume() then calls intel_pstate_resume(), which does not
>    touch the register without HWP, and starts the governor.  The
>    performance governor asks for policy->max, which is equal to
>    policy->cur, so __cpufreq_driver_target() returns without calling
>    the driver.  Even if it did, intel_cpufreq_update_pstate() would
>    skip the write, because the requested P-state matches the cached
>    one.
>
> Governors that change the request often, like schedutil, write the
> register again shortly after resume, so they mostly hide the problem.
> In the active mode, intel_pstate_set_policy() writes the register for
> the nonboot CPUs when they come back online.
>
> Fix this by adding a ->resume() callback to intel_cpufreq that writes
> the cached P-state back to the register when HWP is not used, before
> calling intel_pstate_resume().  The governor of the policy is not
> running at that point, and the write is done under the policy rwsem,
> so it cannot race with updates of the policy limits either.
>
> The problem was found and root-caused, and this patch was drafted, with
> the help of an AI coding assistant (Claude, by Anthropic) during a
> performance review of the machine described above.
>
> Fixes: 4adcf2e5829f ("cpufreq: intel_pstate: Add ->offline and ->online c=
allbacks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zak Brighton Knight <zakbrightonknight@gmail.com>

This patch would correct the observed behavior with intel_pstate, but
it has drawbacks.

First, it papers over issues in the cpufreq core that may affect more
drivers in principle.

Second, it adds IPI overhead to the resume path that is entirely
avoidable AFAICS.

The first core issue related to it that should be addressed in general
is suspend/resume synchronization in it that is insufficient because
the cpufreq_suspended global variable is accessed locklessly, so its
updates are subject to reordering with respect to other operations and
may be missed by concurrent threads running on other CPUs.
Fortunately, this can be done in a straightforward way by replacing
cpufreq_suspended with a per-policy "suspended" flag updated under the
policy rwsem.

Another related core issue is that policy->cur is retained after
stopping the governor during suspend, even though it may be stale
during the subsequent resume, which generally doesn't affect drivers
implementing the .get() callback because of the
cpufreq_verify_current_freq() call in cpufreq_start_governor().
intel_pstate doesn't implement that callback though and so it allows
the stale policy->cur to be used past the governor restart during
resume and there may be other drivers that don't implement .get() in
principle.

After addressing the previous issue, fixing this one is a matter of
clearing policy->cur at suspend time.

The intel_pstate-specific issue, which is that
cpu->pstate.current_pstate is retained across suspend-resume, even
though it may be stale during resume, can also be addressed by
clearing that field at suspend time.  Doing so doesn't require any
special synchronization after fixing the first core issue above
because the core will prevent the frequency from being updated and so
there will be no other cpu->pstate.current_pstate updates till resume.

So please test the attached patch (that needs to be split before
submitting etc) and let me know if it works for you.

Thanks!

--000000000000cb01f9065ee88e42
Content-Type: application/x-patch; 
	name="cpufreq-intel-pstate-suspend-resume.patch"
Content-Disposition: attachment; 
	filename="cpufreq-intel-pstate-suspend-resume.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mvs9ssnd0>
X-Attachment-Id: f_mvs9ssnd0

LS0tCiBkcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcS5jICAgICAgfCAgIDcxICsrKysrKysrKysrKysr
KysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tCiBkcml2ZXJzL2NwdWZyZXEvaW50ZWxfcHN0YXRl
LmMgfCAgIDE0ICsrKysrKystCiBpbmNsdWRlL2xpbnV4L2NwdWZyZXEuaCAgICAgICAgfCAgICAz
ICsKIDMgZmlsZXMgY2hhbmdlZCwgNTQgaW5zZXJ0aW9ucygrKSwgMzQgZGVsZXRpb25zKC0pCgot
LS0gYS9kcml2ZXJzL2NwdWZyZXEvY3B1ZnJlcS5jCisrKyBiL2RyaXZlcnMvY3B1ZnJlcS9jcHVm
cmVxLmMKQEAgLTY2LDkgKzY2LDYgQEAgYm9vbCBjcHVmcmVxX3N1cHBvcnRzX2ZyZXFfaW52YXJp
YW5jZSh2bwogCXJldHVybiBzdGF0aWNfYnJhbmNoX2xpa2VseSgmY3B1ZnJlcV9mcmVxX2ludmFy
aWFuY2UpOwogfQogCi0vKiBGbGFnIHRvIHN1c3BlbmQvcmVzdW1lIENQVUZyZXEgZ292ZXJub3Jz
ICovCi1zdGF0aWMgYm9vbCBjcHVmcmVxX3N1c3BlbmRlZDsKLQogc3RhdGljIGlubGluZSBib29s
IGhhc190YXJnZXQodm9pZCkKIHsKIAlyZXR1cm4gY3B1ZnJlcV9kcml2ZXItPnRhcmdldF9pbmRl
eCB8fCBjcHVmcmVxX2RyaXZlci0+dGFyZ2V0OwpAQCAtMTk1Niw2ICsxOTUzLDE5IEBAIGludCBj
cHVmcmVxX2dlbmVyaWNfc3VzcGVuZChzdHJ1Y3QgY3B1ZnIKIH0KIEVYUE9SVF9TWU1CT0woY3B1
ZnJlcV9nZW5lcmljX3N1c3BlbmQpOwogCitzdGF0aWMgdm9pZCBjcHVmcmVxX3N1c3BlbmRfcG9s
aWN5KHN0cnVjdCBjcHVmcmVxX3BvbGljeSAqcG9saWN5KQoreworCWd1YXJkKGNwdWZyZXFfcG9s
aWN5X3dyaXRlKShwb2xpY3kpOworCisJY3B1ZnJlcV9zdG9wX2dvdmVybm9yKHBvbGljeSk7CisJ
cG9saWN5LT5zdXNwZW5kZWQgPSB0cnVlOworCS8qCisJICogSW52YWxpZGF0ZSB0aGUgY2FjaGVk
IGN1cnJlbnQgZnJlcXVlbmN5IHRoYXQgbWF5IGJlIHN0YWxlIHdoZW4gdGhlCisJICogZ292ZXJu
b3IgaXMgcmVzdGFydGVkIGR1cmluZyByZXN1bWUuCisJICovCisJcG9saWN5LT5jdXIgPSAwOwor
fQorCiAvKioKICAqIGNwdWZyZXFfc3VzcGVuZCgpIC0gU3VzcGVuZCBDUFVGcmVxIGdvdmVybm9y
cy4KICAqCkBAIC0xOTcxLDI3ICsxOTgxLDM0IEBAIHZvaWQgY3B1ZnJlcV9zdXNwZW5kKHZvaWQp
CiAJaWYgKCFjcHVmcmVxX2RyaXZlcikKIAkJcmV0dXJuOwogCi0JY3B1c19yZWFkX2xvY2soKTsK
IAlpZiAoIWhhc190YXJnZXQoKSAmJiAhY3B1ZnJlcV9kcml2ZXItPnN1c3BlbmQpCi0JCWdvdG8g
c3VzcGVuZDsKKwkJcmV0dXJuOwogCiAJcHJfZGVidWcoIiVzOiBTdXNwZW5kaW5nIEdvdmVybm9y
c1xuIiwgX19mdW5jX18pOwogCisJZ3VhcmQoY3B1c19yZWFkX2xvY2spKCk7CisKIAlmb3JfZWFj
aF9hY3RpdmVfcG9saWN5KHBvbGljeSkgewotCQlpZiAoaGFzX3RhcmdldCgpKSB7Ci0JCQlzY29w
ZWRfZ3VhcmQoY3B1ZnJlcV9wb2xpY3lfd3JpdGUsIHBvbGljeSkgewotCQkJCWNwdWZyZXFfc3Rv
cF9nb3Zlcm5vcihwb2xpY3kpOwotCQkJfQotCQl9CisJCWlmIChoYXNfdGFyZ2V0KCkpCisJCQlj
cHVmcmVxX3N1c3BlbmRfcG9saWN5KHBvbGljeSk7CiAKIAkJaWYgKGNwdWZyZXFfZHJpdmVyLT5z
dXNwZW5kICYmIGNwdWZyZXFfZHJpdmVyLT5zdXNwZW5kKHBvbGljeSkpCiAJCQlwcl9lcnIoIiVz
OiBGYWlsZWQgdG8gc3VzcGVuZCBkcml2ZXI6ICVzXG4iLCBfX2Z1bmNfXywKIAkJCQljcHVmcmVx
X2RyaXZlci0+bmFtZSk7CiAJfQorfQorCitzdGF0aWMgdm9pZCBjcHVmcmVxX3Jlc3VtZV9wb2xp
Y3koc3RydWN0IGNwdWZyZXFfcG9saWN5ICpwb2xpY3kpCit7CisJZ3VhcmQoY3B1ZnJlcV9wb2xp
Y3lfd3JpdGUpKHBvbGljeSk7CisKKwlpZiAoIXBvbGljeS0+c3VzcGVuZGVkKQorCQlyZXR1cm47
CiAKLXN1c3BlbmQ6Ci0JY3B1ZnJlcV9zdXNwZW5kZWQgPSB0cnVlOwotCWNwdXNfcmVhZF91bmxv
Y2soKTsKKwlwb2xpY3ktPnN1c3BlbmRlZCA9IGZhbHNlOworCWlmIChjcHVmcmVxX3N0YXJ0X2dv
dmVybm9yKHBvbGljeSkpCisJCXByX2VycigiJXM6IEZhaWxlZCB0byBzdGFydCBnb3Zlcm5vciBm
b3IgQ1BVJXUncyBwb2xpY3lcbiIsCisJCSAgICAgICBfX2Z1bmNfXywgcG9saWN5LT5jcHUpOwog
fQogCiAvKioKQEAgLTIwMDMsMTYgKzIwMjAsMTAgQEAgc3VzcGVuZDoKIHZvaWQgY3B1ZnJlcV9y
ZXN1bWUodm9pZCkKIHsKIAlzdHJ1Y3QgY3B1ZnJlcV9wb2xpY3kgKnBvbGljeTsKLQlpbnQgcmV0
OwogCiAJaWYgKCFjcHVmcmVxX2RyaXZlcikKIAkJcmV0dXJuOwogCi0JaWYgKHVubGlrZWx5KCFj
cHVmcmVxX3N1c3BlbmRlZCkpCi0JCXJldHVybjsKLQotCWNwdWZyZXFfc3VzcGVuZGVkID0gZmFs
c2U7Ci0KIAlpZiAoIWhhc190YXJnZXQoKSAmJiAhY3B1ZnJlcV9kcml2ZXItPnJlc3VtZSkKIAkJ
cmV0dXJuOwogCkBAIC0yMDIzLDEzICsyMDM0LDcgQEAgdm9pZCBjcHVmcmVxX3Jlc3VtZSh2b2lk
KQogCQkJcHJfZXJyKCIlczogRmFpbGVkIHRvIHJlc3VtZSBkcml2ZXI6ICVzXG4iLCBfX2Z1bmNf
XywKIAkJCQljcHVmcmVxX2RyaXZlci0+bmFtZSk7CiAJCX0gZWxzZSBpZiAoaGFzX3RhcmdldCgp
KSB7Ci0JCQlzY29wZWRfZ3VhcmQoY3B1ZnJlcV9wb2xpY3lfd3JpdGUsIHBvbGljeSkgewotCQkJ
CXJldCA9IGNwdWZyZXFfc3RhcnRfZ292ZXJub3IocG9saWN5KTsKLQkJCX0KLQotCQkJaWYgKHJl
dCkKLQkJCQlwcl9lcnIoIiVzOiBGYWlsZWQgdG8gc3RhcnQgZ292ZXJub3IgZm9yIENQVSV1J3Mg
cG9saWN5XG4iLAotCQkJCSAgICAgICBfX2Z1bmNfXywgcG9saWN5LT5jcHUpOworCQkJY3B1ZnJl
cV9yZXN1bWVfcG9saWN5KHBvbGljeSk7CiAJCX0KIAl9CiB9CkBAIC0yNDE2LDggKzI0MjEsOCBA
QCBzdGF0aWMgaW50IGNwdWZyZXFfaW5pdF9nb3Zlcm5vcihzdHJ1Y3QKIHsKIAlpbnQgcmV0Owog
Ci0JLyogRG9uJ3Qgc3RhcnQgYW55IGdvdmVybm9yIG9wZXJhdGlvbnMgaWYgd2UgYXJlIGVudGVy
aW5nIHN1c3BlbmQgKi8KLQlpZiAoY3B1ZnJlcV9zdXNwZW5kZWQpCisJLyogRG9uJ3Qgc3RhcnQg
YW55IGdvdmVybm9yIG9wZXJhdGlvbnMgZm9yIHN1c3BlbmRlZCBwb2xpY2llcy4gKi8KKwlpZiAo
cG9saWN5LT5zdXNwZW5kZWQpCiAJCXJldHVybiAwOwogCS8qCiAJICogR292ZXJub3IgbWlnaHQg
bm90IGJlIGluaXRpYXRlZCBoZXJlIGlmIEFDUEkgX1BQQyBjaGFuZ2VkCkBAIC0yNDYwLDcgKzI0
NjUsNyBAQCBzdGF0aWMgaW50IGNwdWZyZXFfaW5pdF9nb3Zlcm5vcihzdHJ1Y3QKIAogc3RhdGlj
IHZvaWQgY3B1ZnJlcV9leGl0X2dvdmVybm9yKHN0cnVjdCBjcHVmcmVxX3BvbGljeSAqcG9saWN5
KQogewotCWlmIChjcHVmcmVxX3N1c3BlbmRlZCB8fCAhcG9saWN5LT5nb3Zlcm5vcikKKwlpZiAo
cG9saWN5LT5zdXNwZW5kZWQgfHwgIXBvbGljeS0+Z292ZXJub3IpCiAJCXJldHVybjsKIAogCXBy
X2RlYnVnKCIlczogZm9yIENQVSAldVxuIiwgX19mdW5jX18sIHBvbGljeS0+Y3B1KTsKQEAgLTI0
NzUsNyArMjQ4MCw3IEBAIGludCBjcHVmcmVxX3N0YXJ0X2dvdmVybm9yKHN0cnVjdCBjcHVmcmUK
IHsKIAlpbnQgcmV0OwogCi0JaWYgKGNwdWZyZXFfc3VzcGVuZGVkKQorCWlmIChwb2xpY3ktPnN1
c3BlbmRlZCkKIAkJcmV0dXJuIDA7CiAKIAlpZiAoIXBvbGljeS0+Z292ZXJub3IpCkBAIC0yNDk5
LDcgKzI1MDQsNyBAQCBpbnQgY3B1ZnJlcV9zdGFydF9nb3Zlcm5vcihzdHJ1Y3QgY3B1ZnJlCiAK
IHZvaWQgY3B1ZnJlcV9zdG9wX2dvdmVybm9yKHN0cnVjdCBjcHVmcmVxX3BvbGljeSAqcG9saWN5
KQogewotCWlmIChjcHVmcmVxX3N1c3BlbmRlZCB8fCAhcG9saWN5LT5nb3Zlcm5vcikKKwlpZiAo
cG9saWN5LT5zdXNwZW5kZWQgfHwgIXBvbGljeS0+Z292ZXJub3IpCiAJCXJldHVybjsKIAogCXBy
X2RlYnVnKCIlczogZm9yIENQVSAldVxuIiwgX19mdW5jX18sIHBvbGljeS0+Y3B1KTsKQEAgLTI1
MTAsNyArMjUxNSw3IEBAIHZvaWQgY3B1ZnJlcV9zdG9wX2dvdmVybm9yKHN0cnVjdCBjcHVmcmUK
IAogc3RhdGljIHZvaWQgY3B1ZnJlcV9nb3Zlcm5vcl9saW1pdHMoc3RydWN0IGNwdWZyZXFfcG9s
aWN5ICpwb2xpY3kpCiB7Ci0JaWYgKGNwdWZyZXFfc3VzcGVuZGVkIHx8ICFwb2xpY3ktPmdvdmVy
bm9yKQorCWlmIChwb2xpY3ktPnN1c3BlbmRlZCB8fCAhcG9saWN5LT5nb3Zlcm5vcikKIAkJcmV0
dXJuOwogCiAJcHJfZGVidWcoIiVzOiBmb3IgQ1BVICV1XG4iLCBfX2Z1bmNfXywgcG9saWN5LT5j
cHUpOwpAQCAtMjc0Nyw3ICsyNzUyLDcgQEAgc3RhdGljIHZvaWQgY3B1ZnJlcV9wb2xpY3lfcmVm
cmVzaChzdHJ1YwogCSAqIC0+IGFzayBkcml2ZXIgZm9yIGN1cnJlbnQgZnJlcSBhbmQgbm90aWZ5
IGdvdmVybm9ycyBhYm91dCBhIGNoYW5nZQogCSAqLwogCWlmIChjcHVmcmVxX2RyaXZlci0+Z2V0
ICYmIGhhc190YXJnZXQoKSAmJgotCSAgICAoY3B1ZnJlcV9zdXNwZW5kZWQgfHwgV0FSTl9PTigh
Y3B1ZnJlcV92ZXJpZnlfY3VycmVudF9mcmVxKHBvbGljeSwgZmFsc2UpKSkpCisJICAgIChwb2xp
Y3ktPnN1c3BlbmRlZCB8fCBXQVJOX09OKCFjcHVmcmVxX3ZlcmlmeV9jdXJyZW50X2ZyZXEocG9s
aWN5LCBmYWxzZSkpKSkKIAkJcmV0dXJuOwogCiAJcmVmcmVzaF9mcmVxdWVuY3lfbGltaXRzKHBv
bGljeSk7Ci0tLSBhL2RyaXZlcnMvY3B1ZnJlcS9pbnRlbF9wc3RhdGUuYworKysgYi9kcml2ZXJz
L2NwdWZyZXEvaW50ZWxfcHN0YXRlLmMKQEAgLTMzODksMTAgKzMzODksMTIgQEAgc3RhdGljIHZv
aWQgaW50ZWxfY3B1ZnJlcV9jcHVfZXhpdChzdHJ1YwogCiBzdGF0aWMgaW50IGludGVsX2NwdWZy
ZXFfc3VzcGVuZChzdHJ1Y3QgY3B1ZnJlcV9wb2xpY3kgKnBvbGljeSkKIHsKKwlzdHJ1Y3QgY3B1
ZGF0YSAqY3B1OworCiAJaW50ZWxfcHN0YXRlX3N1c3BlbmQocG9saWN5KTsKIAorCWNwdSA9IGFs
bF9jcHVfZGF0YVtwb2xpY3ktPmNwdV07CiAJaWYgKGh3cF9hY3RpdmUpIHsKLQkJc3RydWN0IGNw
dWRhdGEgKmNwdSA9IGFsbF9jcHVfZGF0YVtwb2xpY3ktPmNwdV07CiAJCXU2NCB2YWx1ZSA9IFJF
QURfT05DRShjcHUtPmh3cF9yZXFfY2FjaGVkKTsKIAogCQkvKgpAQCAtMzQwMyw2ICszNDA1LDE2
IEBAIHN0YXRpYyBpbnQgaW50ZWxfY3B1ZnJlcV9zdXNwZW5kKHN0cnVjdAogCQl2YWx1ZSAmPSB+
SFdQX0RFU0lSRURfUEVSRih+MEwpOwogCQl3cm1zcnFfb25fY3B1KGNwdS0+Y3B1LCBNU1JfSFdQ
X1JFUVVFU1QsIHZhbHVlKTsKIAkJV1JJVEVfT05DRShjcHUtPmh3cF9yZXFfY2FjaGVkLCB2YWx1
ZSk7CisJfSBlbHNlIHsKKwkJLyoKKwkJICogSW52YWxpZGF0ZSB0aGUgY2FjaGVkIFAtc3RhdGUg
dmFsdWUgdGhhdCBtYXkgYmUgc3RhbGUgd2hlbgorCQkgKiB0aGUgZ292ZXJub3IgaXMgc3RhcnRl
ZCBhZ2FpbiBkdXJpbmcgcmVzdW1lLgorCQkgKgorCQkgKiBUaGlzIGRvZXMgbm90IHJlcXVpcmUg
c3luY2hyb25pemF0aW9uIGJlY2F1c2UgdGhlIGNvcmUKKwkJICogcHJldmVudHMgZnJlcXVlbmN5
IHVwZGF0ZXMgZm9yIHN1c3BlbmRlZCBwb2xpY2llcyBmcm9tCisJCSAqIG9jY3VycmluZy4KKwkJ
ICovCisJCWNwdS0+cHN0YXRlLmN1cnJlbnRfcHN0YXRlID0gMDsKIAl9CiAKIAlyZXR1cm4gMDsK
LS0tIGEvaW5jbHVkZS9saW51eC9jcHVmcmVxLmgKKysrIGIvaW5jbHVkZS9saW51eC9jcHVmcmVx
LmgKQEAgLTE0OSw2ICsxNDksOSBAQCBzdHJ1Y3QgY3B1ZnJlcV9wb2xpY3kgewogCS8qIFBlbmRp
bmcgcG9saWN5LT5taW4vbWF4IHVwZGF0ZSBmb3IgdGhlIGRyaXZlciAqLwogCWJvb2wJCQl1cGRh
dGVfbGltaXRzOwogCisJLyogVGhlIHBvbGljeSBoYXMgYmVlbiBzdXNwZW5kZWQuICovCisJYm9v
bAkJCXN1c3BlbmRlZDsKKwogCSAvKiBDYWNoZWQgZnJlcXVlbmN5IGxvb2t1cCBmcm9tIGNwdWZy
ZXFfZHJpdmVyX3Jlc29sdmVfZnJlcS4gKi8KIAl1bnNpZ25lZCBpbnQgY2FjaGVkX3RhcmdldF9m
cmVxOwogCXVuc2lnbmVkIGludCBjYWNoZWRfcmVzb2x2ZWRfaWR4Owo=
--000000000000cb01f9065ee88e42--
