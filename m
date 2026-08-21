Received: from e234-52.smtp-out.ap-northeast-1.amazonses.com (e234-52.smtp-out.ap-northeast-1.amazonses.com [23.251.234.52])
	(using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D80E30D407
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 12:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.251.234.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787315932; cv=none; b=ntZ8715CY7WriqTu9wl4WHbRseU+9wtCI6VRpRPNKpJOx/l2byaDRlh4EG3KAV/6dNHcjdaAR+MWK3O8e48q7yKE15qXB/uh7AYTPknY2Fwi068tDQd8mBKlEhqoo4Qt15iPCiT+WUSftuVjeEjx76KWz+ruQhtWEuUA3lhRiRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787315932; c=relaxed/simple;
	bh=ysBNO3Ue3SovkIU74+VCoeihzO2p2re0zO2gAsms+10=;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Date:MIME-Version:
	 Content-Type; b=TKWCWne3UbPdOJWUIO1xxLhx2qkjb7hrimvPcTlLyxkmIMWEaYHX0dxbeH2RQheedCxkZxS4PF8yILXx1+uFtADxY4/nc5umLi5DiLW9EnfwboUsCXDuxOdO2caSQJ0QkPoEwRw49sT1+w9SZePMqQqdyuJb5oE3X8A1oTccfVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me; spf=pass smtp.mailfrom=send.mgml.me; dkim=pass (1024-bit key) header.d=mgml.me header.i=@mgml.me header.b=mT+DkWrv; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=IGpUrxsw; arc=none smtp.client-ip=23.251.234.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mgml.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=send.mgml.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mgml.me header.i=@mgml.me header.b="mT+DkWrv";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="IGpUrxsw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple; s=resend;
	d=mgml.me; t=1787315929;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type;
	bh=ysBNO3Ue3SovkIU74+VCoeihzO2p2re0zO2gAsms+10=;
	b=mT+DkWrvHsVMQ+Wipo1zDDygl89bduD1OK083gtDrZAKaQBn1V0EVvN+nkbRV8qt
	1PcoSSa9FLtdFuzGC6XAAOHEe6LVk9aD33EjEEZjc4MbJaFF/47b67qrnRgjtx7NTTC
	+RQUsFjU0+d4XyhzhTMW0pth4qhw6o+UusO6hk8o=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zh4gjftm6etwoq6afzugpky45synznly; d=amazonses.com; t=1787315929;
	h=In-Reply-To:From:To:Cc:Subject:Message-ID:Content-Transfer-Encoding:Date:MIME-Version:Content-Type:Feedback-ID;
	bh=ysBNO3Ue3SovkIU74+VCoeihzO2p2re0zO2gAsms+10=;
	b=IGpUrxswim+Iss/GffVua0xHPPifu6aaSZAcfU4DQeqx4bd90zQAFuIZIJvr3YSK
	G38iSvQPZWfR+MjIgNwNS7ntn/LAAUYhftLasYEDAR91+dVW0q8p/FFJjhodDYn1pfo
	Lu2TzXwkjqm+MHE73yoilMHhr+XjyROxpRTUVVoU=
User-Agent: Mozilla Thunderbird
Content-Language: en-US
In-Reply-To: <20260730192933.3123642-6-sashal@kernel.org>
From: Kenta Akagi <k@mgml.me>
To: sashal@kernel.org, stable@vger.kernel.org
Cc: dmatlack@google.com, isaku.yamahata@intel.com, pbonzini@redhat.com
Subject: Re: [PATCH 5.15.y 6/6] KVM: x86/mmu: Rename __direct_map() to
 direct_map()
Message-ID: <010601a02454bfc0-33fc8bd0-1233-4be1-a122-da1f9490105d-000000@ap-northeast-1.amazonses.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 12:38:49 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Feedback-ID: :1.ap-northeast-1.SskAFE1oaJ7KCjyyJFCV37nkSRmUZttpeGoevLE2CszduPSq19CK0OWqrkMmPMemkYWmFvQfvS6+lCR9ETv8vDWvEFaQZtUQ69n4DuGGNbGH4U7i+CnKWCHWm/HpilUFxPcCpCRFiQTHPHnKlfimqanQj7AjyJ2y8XQuaQGs83Sl+MS5tJ/lS6+Uh2zwyhRo:1.ap-northeast-1.TOS0vxEE3Ar6ai29fkp2i/jb+l2iigajCGeLfF7S3sk=:AmazonSES
X-SES-Outgoing: 2026.08.21-23.251.234.52

Hi Sasha,

On 2026/07/31 4:29, Sasha Levin wrote:
> From: David Matlack =
<dmatlack@google.com>
>=20
> [ Upstream commit 6c882ef4fc7bd99b67ad152e7542=
8b669281c521 ]
>=20
> Rename __direct_map() to direct_map() since the =
leading underscores are
> unnecessary. This also makes the page fault =
handler names more
> consistent: kvm_tdp_mmu_page_fault() calls =
kvm_tdp_mmu_map() and
> direct_page_fault() calls direct_map().
>=20
> Opportunistically make some trivial cleanups to comments that had to be
> modified anyway since they mentioned __direct_map(). Specifically, use
> "()" when referring to functions, and include kvm_tdp_mmu_map() among
> the various callers of disallowed_hugepage_adjust().
>=20
> No functional change intended.
>=20
> Signed-off-by: David Matlack =
<dmatlack@google.com>
> Reviewed-by: Isaku Yamahata <isaku.yamahata@intel.=
com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-Id: <20220921173546.2674386-11-dmatlack@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Stable-dep-of: 2abd5287f083 ("KVM: x86: Check for invalid/obsolete root =
*after* making MMU pages available")

Maybe I'm missing something, but =
commit 2abd5287f083 ("KVM: x86: Check for
invalid/obsolete root *after* =
making MMU pages available") cannot be backported
as-is. It depends on =
is_page_fault_stale(), introduced by commit a955cad84cda
("KVM: x86/mmu: Retry page fault if root is invalidated by memslot update")=
,
which is missing in 5.15.y.

Furthermore, a955cad84cda is required to fix=
 a regression in 5.15.y when
applying the CVE-2026-46113 and CVE-2026-53359=
 fixes, but its backport remains
pending [1][2].

I plan to send a manual =
backport of a955cad84cda and 2abd5287f083.
In doing so, the interface of =
is_page_fault_stale() will end up incompatible
with mainline. While not =
ideal, making the interface compatible requires=20
struct kvm_page_fault =
and its 50+ prerequisite commits.

[1] https://lore.kernel.=
org/all/20260626174620.1819772-7-pbonzini@redhat.com/
[2] https://lore.kernel.org/all/CABgObfaKqT0gMUB_XRP5DW5HmpgaoTgmD-A8_zQVG2=
Vp5xZE4g@mail.gmail.com/

Thanks,
akagi

> Signed-off-by: Sasha Levin =
<sashal@kernel.org>
> ---
>  arch/x86/kvm/mmu/mmu.c | 20 =
++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 04e814816b17..c274ab0ceff9 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -2991,11 +2991,11 @@ void =
disallowed_hugepage_adjust(u64 spte, gfn_t gfn, int cur_level,
>  	    is_shadow_present_pte(spte) &&
>  	    !is_large_pte(spte)) {
>  		/*
> -		 * A small SPTE exists for this pfn, but FNAME(fetch)
> -		 * and __direct_map would like to create a large PTE
> -		 * instead: just force them to go down another level,
> -		 * patching back for them into pfn the next 9 bits of
> -		 * the address.
> +		 * A small SPTE exists for this pfn, but =
FNAME(fetch),
> +		 * direct_map(), or kvm_tdp_mmu_map() would like to =
create a
> +		 * large PTE instead: just force them to go down another =
level,
> +		 * patching back for them into pfn the next 9 bits of the
> +		 * address.
>  		 */
>  		u64 page_mask =3D KVM_PAGES_PER_HPAGE(level)=
 -
>  				KVM_PAGES_PER_HPAGE(level - 1);
> @@ -3004,9 +3004,9 @@ void =
disallowed_hugepage_adjust(u64 spte, gfn_t gfn, int cur_level,
>  	}
>  }
> =20
> -static int __direct_map(struct kvm_vcpu *vcpu, gpa_t gpa, u32 =
error_code,
> -			int map_writable, int max_level, kvm_pfn_t pfn,
> -			bool prefault, bool is_tdp)
> +static int direct_map(struct kvm_vcpu =
*vcpu, gpa_t gpa, u32 error_code,
> +		      int map_writable, int =
max_level, kvm_pfn_t pfn,
> +		      bool prefault, bool is_tdp)
>  {
>  	bool nx_huge_page_workaround_enabled =3D is_nx_huge_page_enabled();
>  	bool write =3D error_code & PFERR_WRITE_MASK;
> @@ -4037,8 +4037,8 @@ =
static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 =
error_code,
>  	if (r)
>  		goto out_unlock;
> =20
> -	r =3D =
__direct_map(vcpu, gpa, error_code, map_writable, max_level, pfn,
> -			 prefault, is_tdp);
> +	r =3D direct_map(vcpu, gpa, error_code, =
map_writable, max_level, pfn,
> +		       prefault, is_tdp);
> =20
>  out_unlock:
>  	write_unlock(&vcpu->kvm->mmu_lock);
> --=20
> 2.53.0
>=20
>=20
>=20

