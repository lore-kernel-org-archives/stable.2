Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.235
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575945;
	b=3x5ZV7ldbTrWkbP0Ja6nW21cZviqSEYQkzeEWdNE2Ph/JJq/F8gb+qiOl9TwtZ2tKAYK
	 ocdvqW4t95RTXf/rUxQNodxhnLDgQPOLHocoSyNHpQFY96vkZ1/kcNYYas3VBY8syFMkA
	 V4vY8Eq/aJugAtqZ0SrRgIHCwmyFkOF2l5VOY/T9/EW7Gvx+IQgKOcKolkVhEx8+U4FPA
	 HhahtE/26LfyJqlEEXieIH8CNha+ZosCP16YXu9O9iAOKZC6uMxMsQDuiOgWnfBP7UC7m
	 8JZ2+5J/etHMjRZl7P5rvfZEtoHiTYOi0k2jSA+m8/f56sXa5lP1TxJ5hFuwEtMB4gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575945;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:X-OQ-MSGID:References:
	 To:X-Mailer;
	bh=zOT8ULuWUZ+Pol0kbZciWpzJs7R4aMPwJCDXLbZJofE=;
	b=cf3IYJkiWBOAFFX/nR/YlD+3W/mnwyzdw1Tw7V3ms/SUnaIHXPuTMPi6D0ajboRjCWql
	 TalJqYGzY9LgpWuCrK4of+zMDusOBpmtTQo9SD1Zygp4U1rrU6UzJpNa+ID+CeSM+7zqV
	 +WJf2YAN4jWreceZ7eZzenKbmB4bOFAklvDXfMrePA2yqfkH5jh90J1ybL/ZetB9lfKW1
	 rJLZFJ+TciI4UsHvST3aUhFt1g0Um1k7Wp224dQnTIBJDbJvBCTqG9vZJDzPx+H3ts59r
	 C7FaMQG+vQDePL5vhdbQlvCvtsK8R1EW01exS/HP/Mg9dn345GX8bt5LbhFo9uIa29w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=cyyself.name;
	spf=pass smtp.mailfrom=cyyself.name;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=DVmMZNZQ;
	arc=none smtp.remote-ip=203.205.221.235
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A329606A32D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 13:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A329606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyyself.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=DVmMZNZQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794575930; bh=zOT8ULuWUZ+Pol0kbZciWpzJs7R4aMPwJCDXLbZJofE=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=DVmMZNZQaIloU0r6h6yx0z/emryn0Lj5toFImjxybDWD7xzN41Z0mySSB5XbOvMsg
	 WJDtgRWYpWxuWXab0oBpmfqBb87YfVb2Ta/Ub9jRVxGyFQPfv+Qj1vP67MBeqhxkaW
	 Put/XiOhoLD2CeVVpWwOjVROBE40/yNRQ3xFVGXE=
Received: from smtpclient.apple ([114.248.29.251])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 4AE8781F; Fri, 13 Nov 2026 21:18:46 +0800
X-QQ-mid: xmsmtpt1794575926tnw98zzgn
Message-ID: <tencent_63C137ED014723DCB818FB1099C661BE3907@qq.com>
X-QQ-XMAILINFO: M0Kf5GqryI/OQtZNR/nMkpGPKn8Y4vTiFP/6DFaA1+vU3yvVZg5B4INp8QMACO
	 NGu5/zUrSaNMZAzobowNKyFdz2+pOCGcL/YJhfcCXteqSAWbWPQHzjkfbDB08FKtzZscw3a4oXg8
	 0X8P4t58dg8njPXEGhvi3Qt/N0yt/jFcb49o2bxkETDY2dpQ54zGgp7U/3U5HPqdIQ85CcuTwRAe
	 jNDXioqb8Tza3fxzv/YiNrznw+UYED3tkncTAQonw2Mk8QGL6jkogYrgHoVAsf4tVRBHcLeB3uKe
	 rWZ/sJE7BCDIK9IMlTJMkrxAbWhIZLqxSZvYrXZJTEQ5wFoM+JvT4U+E7Xjnjj+EITrpkFNP0w9x
	 XgRUrgf4MiIhdMMy70mQ0BGXoab/XrU+fk3VdXzrag71V4GJUxC6tA7HsqciI9iHVTq0OyjDfYuO
	 B1AI8cB3XuakILLUIv36JyQOfx8xtTc5gBwn9DlyIfgu9XN81h5MCg/PwWmqlEfcwU09jTDvnEVD
	 nKehPpV6rCBLj9SrkY/gP3wqqfvsCGk5UsfAxt6p3a2GZmls6gF7JLgI/Mm/osnZoSy7OLRuFuVN
	 3Se/r1Es2wHIHJPHUO0g+d0dnxXmP0H+tOXvi+Tj6w+KxyhuspkNWqD9pWd+C2Xq/UXiMJV6YMCW
	 xHaQsXLgRyVRF7XzcIrALSC3bGbl3G3W/iJmcJrARJvUIbjebdW5fYMer7amson1RRjonHhWIemJ
	 wBd2AaKK8rRxd0Lq6NhnWwCTxlT2BE6ICL2Xh9GpNUgeN+9QMAhbXmG2U5qAqD5+3a4CBVKNxeAu
	 IjhFSbRI56fjHItaGqeM2rLs0lj8K1jSoakfhuVC3OI9tRJTlasLeM/qqeZkxB++6600ScGO5qQa
	 oJv/C7S0Bfzl2NwLf0i5h6TywZUePQ+8zNy4YAF9ukRHJ8Om/nzPgac3/d4/REgkq2QYDDePKiPM
	 TP/cyB52VP4qPkYf46xJGN7J2t1vR9BFAFLxk9CnH/h9mTXiQKP5/EJBy+p3DcB1L31uZtHvbC9q
	 yVbZ8IUOCIZp0DXWm8sSc8u57ApCk=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH] RISC-V: KVM: Fix G-stage page table memory leak on VM
 destroy
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <CAAhSdy3K1AFB-DWKznNru+x2hNiP5_M+uTZEZBHWwdvLfJrNQA@mail.gmail.com>
Date: Fri, 13 Nov 2026 21:18:36 +0800
Cc: atish.patra@linux.dev,
 pjw@kernel.org,
 palmer@dabbelt.com,
 aou@eecs.berkeley.edu,
 alex@ghiti.fr,
 kvm@vger.kernel.org,
 kvm-riscv@lists.infradead.org,
 linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <B7BBA6B1-B82F-4DC6-8579-E46C31B34BD6@cyyself.name>
References: <tencent_C8B170AF63DC42F81A47F9EA044BB4B11C09@qq.com>
 <CAAhSdy3K1AFB-DWKznNru+x2hNiP5_M+uTZEZBHWwdvLfJrNQA@mail.gmail.com>
To: Anup Patel <anup@brainfault.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On 13 Nov 2026, at 20:16, Anup Patel <anup@brainfault.org> wrote:
>=20
> On Sat, Oct 31, 2026 at 12:28=E2=80=AFAM Yangyu Chen =
<cyy@cyyself.name> wrote:
>>=20
>> kvm_riscv_mmu_free_pgd() tears down the G-stage with
>> kvm_riscv_gstage_unmap_range() over the whole guest physical address
>> space. That function looks up each address with
>> kvm_riscv_gstage_get_leaf(), which walks down to the leaf PTE, and =
then
>> clears only that leaf. kvm_riscv_gstage_op_pte() frees a page table =
only
>> when it is called on a non-leaf PTE, which never happens here, so =
every
>> page table below the PGD is leaked when a VM is destroyed. With 4 KiB
>> mappings this is one page per 2 MiB of guest memory that was ever
>> mapped, plus the upper-level tables.
>>=20
>> The leaked pages are not slab, vmalloc or page cache, so they show up
>> only as unaccounted used memory. On a SpacemiT K3 host, a workload =
that
>> creates and destroys tens of thousands of small VMs leaked 0.5-1 MiB =
per
>> VM and ran the host out of memory after about 20,000 VMs.
>>=20
>> Add kvm_riscv_gstage_unmap_all(), which calls =
kvm_riscv_gstage_op_pte()
>> with GSTAGE_OP_CLEAR on every PGD entry. That recursively clears all
>> leaf PTEs and frees each page table below the PGD. Use it in
>> kvm_riscv_mmu_free_pgd().
>>=20
>> Tested with a reproducer script that builds a minimal KVM host kernel
>> from a source tree and boots it under QEMU 11.0.2 (TCG, rv64 with H,
>> Sv57x4 G-stage). Its init creates 10 VMs one after another. Each =
guest
>> writes one word in every 2 MiB of an 8 GiB RAM region (anonymous =
memory
>> with MADV_NOHUGEPAGE, so 4 KiB G-stage mappings) and then shuts down,
>> so each VM needs 4096 last-level page tables (16 MiB). MemFree lost =
per
>> VM, after one warm-up VM:
>>=20
>>  before:  16415 kB  (RESULT: LEAK)
>>  after:    1636 kB  (RESULT: OK, noise)
>>=20
>> The bug was found while investigating the host OOM, and the fix and
>> reproducer were written with the help of an AI coding assistant
>> (Claude). The analysis, fix and test results above were reviewed by
>> the submitter.
>>=20
>> Fixes: 9d05c1fee837 ("RISC-V: KVM: Implement stage2 page table =
programming")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
>=20
> Good catch. Thanks for the fix.
>=20
> Reviewed-by: Anup Patel <anup@brainfault.org>
>=20
> Queued this patch as a fix for Linux-7.4-rcX
>=20

I think this should also be backported to linux-stable.

Thanks,
Yangyu Chen

> Thanks,
> Anup
>=20
>> ---
>> How to reproduce:
>>=20
>> The reproducer script is at
>> https://gist.github.com/cyyself/23abb87a8ad9ee8c64ce03cca78669fc
>> and needs riscv64-linux-gnu-gcc, qemu-system-riscv64 and cpio. Run it
>> from the top of a kernel source tree:
>>=20
>>        $ cd linux
>>        $ /path/to/kvm-riscv-gstage-leak.sh
>>=20
>> It builds a minimal riscv64 KVM host kernel (allnoconfig + KVM) into
>> .kvm-leak-build/ and boots it under QEMU (TCG, -cpu rv64,h=3Dtrue) =
with a
>> static test program as /init. The test creates 10 VMs one after =
another.
>> Each guest touches one page in every 2 MiB of 8 GiB of guest RAM, so =
it
>> needs 16 MiB of last-level G-stage page tables. The test then prints =
how
>> much MemFree each VM leaves behind. The first run takes about 1.5
>> minutes, mostly kernel build; reruns take about 10 seconds.
>>=20
>> Without this patch:
>>=20
>>        10 VMs, each touching one 4 KiB page per 2 MiB of 8 GiB guest =
RAM
>>        MemFree 2037664 -> 1873512 kB: 16415 kB lost per VM (a leaking =
kernel loses ~16384 kB)
>>        RESULT: LEAK
>>=20
>> With this patch:
>>=20
>>        MemFree 2054080 -> 2037716 kB: 1636 kB lost per VM (a leaking =
kernel loses ~16384 kB)
>>        RESULT: OK
>>=20
>> The exit status is 0 for OK, 1 for LEAK and 2 if the test could not
>> run. IMAGE=3D<path/to/Image> boots an existing kernel instead of =
building
>> one. That kernel needs CONFIG_KVM=3Dy, CONFIG_BLK_DEV_INITRD=3Dy and
>> CONFIG_DEVTMPFS=3Dy.
>>=20
>> I also tested VMs that select Sv39x4, Sv48x4 and Sv57x4 through
>> KVM_CAP_VM_GPA_BITS, and four VMs with mixed modes alive at the same
>> time, destroyed one by one while the remaining VMs kept running and
>> were checked for correct guest memory contents. With this patch, no
>> memory was lost in any mode and no guest data was corrupted. Without
>> it, every mode leaked about 16 MiB per VM.
>> ---
>> arch/riscv/include/asm/kvm_gstage.h |  2 ++
>> arch/riscv/kvm/gstage.c             | 22 ++++++++++++++++++++++
>> arch/riscv/kvm/mmu.c                |  3 +--
>> 3 files changed, 25 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/arch/riscv/include/asm/kvm_gstage.h =
b/arch/riscv/include/asm/kvm_gstage.h
>> index aaf080ba1b77..90ec9e0b34b1 100644
>> --- a/arch/riscv/include/asm/kvm_gstage.h
>> +++ b/arch/riscv/include/asm/kvm_gstage.h
>> @@ -80,6 +80,8 @@ bool kvm_riscv_gstage_op_pte(struct kvm_gstage =
*gstage, gpa_t addr,
>> bool kvm_riscv_gstage_unmap_range(struct kvm_gstage *gstage,
>>                                  gpa_t start, gpa_t size, bool =
may_block);
>>=20
>> +bool kvm_riscv_gstage_unmap_all(struct kvm_gstage *gstage);
>> +
>> bool kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t =
start, gpa_t end);
>>=20
>> bool kvm_riscv_gstage_wp_pt_masked(struct kvm_gstage *gstage, gfn_t =
base_gfn,
>> diff --git a/arch/riscv/kvm/gstage.c b/arch/riscv/kvm/gstage.c
>> index e5002cb9cbef..c912cdc2021f 100644
>> --- a/arch/riscv/kvm/gstage.c
>> +++ b/arch/riscv/kvm/gstage.c
>> @@ -456,6 +456,28 @@ bool kvm_riscv_gstage_unmap_range(struct =
kvm_gstage *gstage,
>>        return flush;
>> }
>>=20
>> +/*
>> + * Clear every G-stage mapping and free all page tables below the =
PGD.
>> + * kvm_riscv_gstage_unmap_range() only clears leaf PTEs and leaves =
the
>> + * page tables in place, so it cannot be used to tear down a =
G-stage.
>> + */
>> +bool kvm_riscv_gstage_unmap_all(struct kvm_gstage *gstage)
>> +{
>> +       u32 level =3D gstage->pgd_levels - 1;
>> +       pte_t *pgd =3D (pte_t *)gstage->pgd;
>> +       unsigned long i, page_size;
>> +       bool flush =3D false;
>> +
>> +       if (gstage_level_to_page_size(gstage, level, &page_size))
>> +               return false;
>> +
>> +       for (i =3D 0; i < kvm_riscv_gstage_pgd_size / sizeof(pte_t); =
i++)
>> +               flush |=3D kvm_riscv_gstage_op_pte(gstage, i * =
page_size, &pgd[i],
>> +                                                level, =
GSTAGE_OP_CLEAR);
>> +
>> +       return flush;
>> +}
>> +
>> bool kvm_riscv_gstage_wp_range(struct kvm_gstage *gstage, gpa_t =
start, gpa_t end)
>> {
>>        int ret;
>> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
>> index 371fccaf9df0..87838a0f6bb9 100644
>> --- a/arch/riscv/kvm/mmu.c
>> +++ b/arch/riscv/kvm/mmu.c
>> @@ -784,8 +784,7 @@ void kvm_riscv_mmu_free_pgd(struct kvm *kvm)
>>        write_lock(&kvm->mmu_lock);
>>        if (kvm->arch.pgd) {
>>                kvm_riscv_gstage_init(&gstage, kvm);
>> -               flush =3D kvm_riscv_gstage_unmap_range(&gstage, 0UL,
>> -                       =
kvm_riscv_gstage_gpa_size(kvm->arch.pgd_levels), false);
>> +               flush =3D kvm_riscv_gstage_unmap_all(&gstage);
>>                pgd =3D READ_ONCE(kvm->arch.pgd);
>>                kvm->arch.pgd =3D NULL;
>>                kvm->arch.pgd_phys =3D 0;
>> --
>> 2.53.0

