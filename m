Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985453DBD41
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 08:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789632719; cv=none; b=Q8yTsWsp95lfWB7TiDnIfiTROv4x2yVv7ZJW6p9+44wNU2eK6Jl7OQEWf/SaxB34FGOh09EDJ1rYnFoH0mD7ealWfVbnihIDqwrGpMDwCY0f/wQuU31ks2JrgalwAW8r3asWuhwdTUpH1cs8LWwD0f0fiUpDeAg6yXpRAEbFAAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789632719; c=relaxed/simple;
	bh=aXi4Ocl4wPLP6DaqHSusLJmAe9fUehN8EncBiZqZaT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxcL2D9756BiQCYaYl8B3sqIqfgh1hBKSjrOqgwaDEdEQBg71a//r3yWb202lrMcvvfhaqxREifjCyx3FJ4SUmXKqFDHj04/wPMuor60ATg0xFXZOmLyTJGdQH7uEbheiSUJnUFvScFpYYFT6qYkUpJYfjuQlsDf2JNY+mmyiUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UTY17t2U; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UTY17t2U"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b5so3235895e9.2
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 01:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789632715; x=1790237515; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fAnlR2dtGuXBbIrYg+IuvuLox4jTD1pnpks7H3lzGUg=;
        b=UTY17t2Uka+1gu+2nEo/zLhkh2d56fc5F5iW0iC7t6Mce/6Z9QPlq7nk0LXp5OEYyi
         byI2k1D12ov9XV58yaMim7dOdTiEiHIglGzxonOoxUYHT4IkqN4eIUVl7E4w4vHsZwBE
         wXheRV0fRltVEx1AYsoFq66PFgl3h2wqQf311wIx2oKLzm22Ucss34ngiF1CqRyvF/rw
         eyx5PCBoNxWJ/2z05jG1kB3IuMrmmhj5wKlmblKc7CHTsQG9PVlWim81qDlxZq8AIc3o
         GZbsS2K7TxFFscYDcPHbNQiY5oQ6IIINLA7TFgahxbc0Ar97Ffogd6BQmUzFbOdAWhpv
         qPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789632715; x=1790237515;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fAnlR2dtGuXBbIrYg+IuvuLox4jTD1pnpks7H3lzGUg=;
        b=0PeIOR5Cu9MbTIH2/8KlcXimNHjfPhw1PYB+ghA9U+qOb6hRmqJM2Um6YeK3BsmmSF
         OgVawHj/aRZF2PAY1h8k4Fna7ogqqietl+G2soAi/+1DzSmh/Iu47mWThl16lRo5NaUP
         c18qZo8gmG12OQJ9P4uCSpjwNppkSoS+CEcOjB2mVOipFN+MRrlkyOnRldOrGZu5HPw4
         XO/2mgvjOfYXJzz07LkanHe915u4WJgtKTcVCaoI5owfcBPb7iMQ5f3cibvPtpu6Ld5n
         feLEBwo7+So48xDgi7ShO7H4ljvE0oFvOkImMfV85W0eI/CcIKd7+iiwHgKg3OqZgLjC
         kWQg==
X-Forwarded-Encrypted: i=1; AKwUvBzBoB4G/8Blq2CvbEGl72eqc1E+Oj6KlMZ/TON0mCZK08nGw1rJTrf07t9Yc9iLFwt5nnfqyzE=@vger.kernel.org
X-Gm-Message-State: AFuF++kJW9jpqS7zvp0VFf0Z13n6GDlwCTb3eYLwWSeL5XM9etMHAMX1
	zRR+HXJnwuX2VWx/jKj6f72MscL/IhfRlpWCS5DYqYOqlJucRpIFY6abV++JUwC7AA==
X-Gm-Gg: AYBFou3sKaOhQrPrGN02Xom6lgh+TYZEOpxiQ9KHescHrW2R7Mmx2gwBbxW1uepQs3/
	fM85TFVdTaGLjNcRHpRHnfXq05kjj5igP7pgewABGEErUQwYyH/B4f/cmrMqKCMsS3Nv6krNnbx
	iCsoR2yiPP3B3qvRvM5LXPD9aUxqXvMtQA/Is71If7qzuEvkyZ/jOKHEaH6Dq5WubXUpfQENncY
	EvNm7MKOSE1TEfjzBpTGBAqPXuriUJvHtp8iPglTVTsi9V+MWpy/6CrWMr7MEfHDTFolZ0pYE2w
	m+97PM+uvrp39clFBRvTM4B2LU0/zandMlu1djxI1nw8jnMQJtqkX8UyBWiyJKtMtbDsQGCCDOs
	fLV4eIsymFc/TFgI4P3J3q4CbU2lcYic+6d67syOXHiRpe99sOnJC5VH8dcl+W5f3rYYo1DaDlj
	7IbZxVhMIg22CUnsGdUm9hdHJDs6cBVsKeXC7tc+qDUr+sExNrxI7I2Cj5REHWW7wdLXdcL66I+
	gkSPQfSZ+Ge8p28GK7eGbf2cVYsBUH+puswyYCrY7TdLrRXULb2DA==
X-Received: by 2002:a05:600c:3b97:b0:49e:6050:9fbe with SMTP id 5b1f17b1804b1-49ebcc010d5mr137864965e9.15.1789632714827;
        Thu, 17 Sep 2026 01:11:54 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd22dbf2sm50558415e9.10.2026.09.17.01.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 01:11:54 -0700 (PDT)
Date: Thu, 17 Sep 2026 09:11:50 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Wei-Lin Chang <weilin.chang@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>, Fuad Tabba <fuad.tabba@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Sebastian Ene <sebastianene@google.com>,
	Itaru Kitayama <itaru.kitayama@fujitsu.com>,
	Sashiko AI <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] KVM: arm64: ptdump: Check the page tables aren't
 freed when accessing
Message-ID: <aqugxlnqegPzMpB-@google.com>
References: <20260916230337.4162485-1-weilin.chang@arm.com>
 <20260916230337.4162485-2-weilin.chang@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260916230337.4162485-2-weilin.chang@arm.com>

On Thu, Sep 17, 2026 at 12:03:36AM +0100, Wei-Lin Chang wrote:
> An open debugfs file keeps the KVM structure alive, but does not prevent
> mmu notifier release from freeing the stage-2 page tables when the VMM’s
> address space is torn down. Therefore page tables belonging to the mmus
> could have been freed when a thread opens or reads the ptdump files.
> Take the mmu_lock and check mmu->pgt is still alive before accessing the
> page tables.

As Sashiko said, the read_lock is probably enough, including the existing one in
kvm_ptdump_guest_show()

With that change:

Reviewed-by: Vincent Donnefort <vdonnefort@google.com>
Tested-by: Vincent Donnefort <vdonnefort@google.com>

> 
> Also for the ipa_range file and stage2_levels file, switch from keeping
> the pointer to the page tables to keeping the pointer to the mmu.
> 
> Fixes: 7c4f73548ed1 ("KVM: arm64: Register ptdump with debugfs on guest creation")
> Reported-by: Sashiko AI <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/kvmarm/20260623144054.B91D21F000E9@smtp.kernel.org/
> Signed-off-by: Wei-Lin Chang <weilin.chang@arm.com>
> Cc: stable@vger.kernel.org
> ---
>  arch/arm64/kvm/ptdump.c | 43 +++++++++++++++++++++++++++++++----------
>  1 file changed, 33 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/kvm/ptdump.c b/arch/arm64/kvm/ptdump.c
> index 69899797dbad..4ead856c181a 100644
> --- a/arch/arm64/kvm/ptdump.c
> +++ b/arch/arm64/kvm/ptdump.c
> @@ -115,15 +115,28 @@ static int kvm_ptdump_build_levels(struct ptdump_pg_level *level, u32 start_lvl)
>  
>  static struct kvm_ptdump_guest_state *kvm_ptdump_parser_create(struct kvm_s2_mmu *mmu)
>  {
> +	struct kvm *kvm = kvm_s2_mmu_to_kvm(mmu);
>  	struct kvm_ptdump_guest_state *st;
> -	struct kvm_pgtable *pgtable = mmu->pgt;
> +	s8 start_level;
>  	int ret;
>  
> +	/*
> +	 * We only need the pgt start level to initialize the ptdump, get it
> +	 * while holding the mmu_lock. It's fine if the pgt gets freed
> +	 * afterwards, we'll check again when doing the actual dump.
> +	 */
> +	scoped_guard(write_lock, &kvm->mmu_lock) {
> +		if (mmu->pgt)
> +			start_level = mmu->pgt->start_level;
> +		else
> +			return ERR_PTR(-ENOENT);
> +	}
> +
>  	st = kzalloc_obj(struct kvm_ptdump_guest_state, GFP_KERNEL_ACCOUNT);
>  	if (!st)
>  		return ERR_PTR(-ENOMEM);
>  
> -	ret = kvm_ptdump_build_levels(&st->level[0], pgtable->start_level);
> +	ret = kvm_ptdump_build_levels(&st->level[0], start_level);
>  	if (ret) {
>  		kfree(st);
>  		return ERR_PTR(ret);
> @@ -149,6 +162,9 @@ static int kvm_ptdump_guest_show(struct seq_file *m, void *unused)
>  	};
>  
>  	guard(write_lock)(&kvm->mmu_lock);
> +	if (!mmu->pgt)
> +		return 0;
> +
>  	st->parser_state = (struct ptdump_pg_state) {
>  		.marker		= &st->ipa_marker[0],
>  		.end_address	= BIT(mmu->pgt->ia_bits),
> @@ -211,17 +227,27 @@ static const struct file_operations kvm_ptdump_guest_fops = {
>  
>  static int kvm_pgtable_range_show(struct seq_file *m, void *unused)
>  {
> -	struct kvm_pgtable *pgtable = m->private;
> +	struct kvm_s2_mmu *mmu = m->private;
> +	struct kvm *kvm = kvm_s2_mmu_to_kvm(mmu);
> +
> +	guard(write_lock)(&kvm->mmu_lock);
> +
> +	if (mmu->pgt)
> +		seq_printf(m, "%2u\n", mmu->pgt->ia_bits);
>  
> -	seq_printf(m, "%2u\n", pgtable->ia_bits);
>  	return 0;
>  }
>  
>  static int kvm_pgtable_levels_show(struct seq_file *m, void *unused)
>  {
> -	struct kvm_pgtable *pgtable = m->private;
> +	struct kvm_s2_mmu *mmu = m->private;
> +	struct kvm *kvm = kvm_s2_mmu_to_kvm(mmu);
> +
> +	guard(write_lock)(&kvm->mmu_lock);
> +
> +	if (mmu->pgt)
> +		seq_printf(m, "%1d\n", KVM_PGTABLE_MAX_LEVELS - mmu->pgt->start_level);
>  
> -	seq_printf(m, "%1d\n", KVM_PGTABLE_MAX_LEVELS - pgtable->start_level);
>  	return 0;
>  }
>  
> @@ -230,15 +256,12 @@ static int kvm_pgtable_debugfs_open(struct inode *m, struct file *file,
>  {
>  	struct kvm_s2_mmu *mmu = m->i_private;
>  	struct kvm *kvm = kvm_s2_mmu_to_kvm(mmu);
> -	struct kvm_pgtable *pgtable;
>  	int ret;
>  
>  	if (!kvm_get_kvm_safe(kvm))
>  		return -ENOENT;
>  
> -	pgtable = mmu->pgt;
> -
> -	ret = single_open(file, show, pgtable);
> +	ret = single_open(file, show, mmu);
>  	if (ret < 0)
>  		kvm_put_kvm(kvm);
>  	return ret;
> -- 
> 2.43.0
> 

-- 
Vincent
