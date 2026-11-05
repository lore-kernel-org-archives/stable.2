Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793880762;
	b=ZKZWI3r0lavVYnrtay7vEswy1BRSXwTOAmftUYkLFf9vme5kg40xhIQz9SV2Aft6wEef
	 zwAet1KZkcT61ZFBwS7t2x+CnHGDVaCagi2o/46GUSV2MJE5MDFed0BsiXWG6RlatIG7N
	 sv4rybemNJYwdApq9HdfJUFgd2FetHvBAoIai6VgBjaotnUggusMSH8ZF0M982wEvsnCk
	 YHpsL7I2vOT9VgOYfxlKLsH2nEiO0C0qZGZ5hhPUifFJsznLzPoidMaYuz5gBrCz3wnDy
	 e8nyaCRA09siFZYVsHgb1b+24MV/bI4QXF80lEmvFEItPYEGwwpwaWX2YKhwj1kKUGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793880762;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=zHMd/dXYh7gIG0cBwUrUnPLYGKq0g6gjljh3Mny/LFw=;
	b=gn26rQEG/1dxHEWBL+hOiCd3tRIbn9zO1Nf5b5dtT3gGtZiK11Cwu1Zh6tMwcsP/I/Lv
	 EzfIixDiDd7uIKtWaIsuEZN/iH0pPLpQ88jle/fu/0MyX6ZK2GtnStNXBiCxHWKv2v82O
	 vhJPk182hemSZ8dbFL3M17x0+PpBij86KUUlkNykof+TGaR3Ryn+E3xodI0Cu7djff2GD
	 tW46lLoHkbLfawIGxKPxX8Qx2ewBZDnegE9LUKPWDM6PQrj7KhP7/Nfwy2EHvUWYnR75d
	 LuEXtwVZpnukjkfiBoPqDtLyzLSUMVHlbaojStgZT6mEH9nAk9HfhP3tcknEqJfgQ5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n83ov0yb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCD4606A32C
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 12:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n83ov0yb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0FBA1F0093A;
	Thu,  5 Nov 2026 12:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793880762;
	bh=zHMd/dXYh7gIG0cBwUrUnPLYGKq0g6gjljh3Mny/LFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=n83ov0ybs9zKjBE+JDKTc4TPiw5KduZShNqgRdasi9NMkwyZpv9GLkz4bkaF9cFXT
	 t1RXCJACx+SLGqI76ahilnF5Hghlr8BcHq5Q4+ctzVdzne1JxE1T80Z+msPh8iSWcG
	 Wq/F1ukxPloyUBAKh2tFffyAngWvC2GqcFWfyMGYXCdIIdsZrI43ONo8fczLlAYQiu
	 fWqAQ2THJmzKgeR6S4k2jBoiMsGdPGbPXgf6Vg1E5v3mf+LXtxpi+Mdycih4L4nz+t
	 bIPbeOyGnj1SwlPupDwntO7HTqvB4zyyzBFD8//WJe/f3ipgyqkUSuZ8zoBTd8wPRa
	 zi1CQyyyWdH+A==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.ams.internal (Postfix) with ESMTP id BFC97198003A;
	Thu,  5 Nov 2026 07:12:38 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 05 Nov 2026 07:12:40 -0500
X-ME-Sender: <xms:tnLsatKWpvswulKG_-ndkBrKLQLI1gU79TIrVbtQEn6pI1aW18xTCg>
    <xme:tnLsaoYbvRuiZ0YqcNqrJ-JBhLTqH08_KeeFGjFaujvQbKWLcRuE3fySPU94bZz_d
    JBHg08cTKfLvfIBsEULgWqkShEEcVC0HytwY-Uj2DSI8-mT3uL3I54>
X-ME-Received: <xmr:tnLsaogQJmRYXQI6KN_HWwqOXeE9GufB7k8H4mYx9jWOL6qMLw1EuTqo5M0>
X-ME-Proxy-Cause: dmFkZTFSCgiRUzVCJYCqptrUSa9RHQsLWQK1L6z9r9zyIOoZgIGHK/fHlQJAVg90TKAzJ3
    s4UplecP7s1f3qOUWNCj5tYaRHeCEDqQKOYgk3SWTs3mYDAtRtLSDSya2S0qC24O4N3NP7
    Hc222vgyIrKhtZHOstUnlYYDNDcxuWUYVxaKNabOt10YTuemJKgd7oOphgIehKzrjXcH+V
    YHa8b2QL81OVg8O0nTCEw0sxzYDLw5LJ1tdblkIm2kd/XRoBN5iuZBfEh0LXeo6+/pZ+Bj
    9/ybhAJ6xcJ/Rib4C9vXdNXcqtFniKdrO19OrbOg5LNTt/el6+WBUWKwXLc7Sy8y3GeZFq
    xAGe7EK8aR7Nld64zmyK1EMnNXKRWPa7dPDsLG7XgfWEx9jXTHU9TApHgygnxsw71KnEhr
    +E0Uc0ouJy3xpuTYTPcPym6iVmVuPwbOHiMJb+4rYKxvdfBnVfQZxTheF/5Dmzo0t+Ihvc
    E2r8qAWyRV3T0wKJMPoyozVSXaLKFLmmDsnespiGkdOim9QHqyZDYJTnQfD/YFJD7Gt/Bd
    MkcHiQLVZMIwvUNZPsfOEelQMt5BXwHLuOxmUIobhmNRBMdOaaZvCGqVn4iTczB4mCBznY
    MWgm/wVf17mSFUw921U8q8JLuzeLlj2XEPeH+nRaAoiFL+3rMtGPysUjxlgw
X-ME-Proxy: <xmx:tnLsal4RQYFZtsdaTsaU_I3frjcOpHVNtg7FlgKyT_8NH1TbATU9eg>
    <xmx:tnLsaoohQzjIGt0BjtURG0YcFYmDLrCm_RVsKKgO0UgpHqCxMnHLoA>
    <xmx:tnLsaqiS8re4jucvqlzhjTO32YU6x9Tj0Fkb2mpLap_1xKXQ7hbw9w>
    <xmx:tnLsaotI_y1-TwwYZCvhRI1cs0nglmjXg4Vdf_JQ7OypcNwe0JuGwA>
    <xmx:tnLsaj2vda6mSJQo077WW3NDOB4_zz7nGw8pJqEEUxn9beWFUfTTcast>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 07:12:37 -0500 (EST)
Date: Thu, 5 Nov 2026 12:12:36 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: willy@infradead.org, jack@suse.cz, akpm@linux-foundation.org, 
	dave.hansen@linux.intel.com, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] filemap: prefault writes starting beyond EOF
Message-ID: <auxyhE-b_fHQ_Eqz@thinkstation>
References: <20261104071002.49693-1-dennylin0707@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104071002.49693-1-dennylin0707@gmail.com>

On Wed, Nov 04, 2026 at 07:10:02AM +0000, Hungyu Lin wrote:
> Since prefaulting moved to the slow write path, a buffered write can reach
> ->write_begin() and ->write_end() before discovering that its source buffer
> is unreadable. Several filesystems can extend i_size in these callbacks
> even when no data was copied. For example, a one-byte pwrite() at offset
> 4096 into an empty file can fail with EFAULT but leave a 4096-byte file.
> 
> Prefault the source before ->write_begin() when the write position is
> beyond EOF, and return EFAULT if no source bytes can be made readable.
> Overwrites and appends continue to skip this prefault. Keep the existing
> slow-path faulting for forward progress after a failed atomic copy.
> 
> This also leaves intentional zero-length ->write_end() calls used by
> generic_cont_expand_simple() unchanged. As with the previous prefaulting
> behavior, a concurrent userspace unmap can still race with the later copy.
> 
> Fixes: 665575cff098 ("filemap: move prefaulting out of hot write path")
> Reported-by: Kiryl Shutsemau <kas@kernel.org>
> Closes: https://lore.kernel.org/linux-mm/at9xXRhD2xZhszEj@thinkstation/
> Suggested-by: Kiryl Shutsemau <kas@kernel.org>
> Link: https://lore.kernel.org/all/at-XtWBQg3jv3H8Z@thinkstation/
> Cc: stable@vger.kernel.org
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>

You found the bug, I only pointed out that it is not tmpfs-specific.
Please drop Reported-by and Closes; Suggested-by and Link are enough.

Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
