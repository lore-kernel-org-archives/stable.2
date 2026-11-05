Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793871846;
	b=lDAuFa/rNGk92jFVJZo49iKyTBSaSmjqwBjGfbezS7vw8yqZWMr41LmvmGL7OOHSiL2g
	 yx1qf3OhDy4A74XcJqb/D0H5bOFHb/fSkN/E1aBEy47hjaE8rt0oBCueq3bN7Krqnn79T
	 x8WAjRy72jpDUSmnbQDN2YkJ9yB3YkV0CJOxcZeb394hhWMGjviVxL/M7icVSpPUPERmZ
	 IINAd7uzpuetdROL10hciC757XHxjWNMv6kytMvF9260VqKNrs/5vTY4LGx+Yep2AB3ec
	 I3XLJKvlNCdSUC86rAJT9aeYVdJRpuF8kmR+lYCUFHPYPcyRgJfhibCLTYrn7rPTy7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793871846;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=cl0o/t0hLxvs36DJVBtguhBYlsrgjBilx1megG1I2r8=;
	b=dtL+r5Um3U1ZnjyG7MnuZknkMtspwz0E78JNxpyq3siXPGuwXXd5mehukQqWHMM6h09z
	 bPB5uw3mz+6R7yOqSzClDnRHNdVgS1teOFLfsqCxdUfEmDvoVzuTt6OUBL0nhCVR9ZUY4
	 5E5Pylxa6UcDsRYVsKEscSguWhTmPgdHnBmzG3x7N3E7v8WzOGXmUmDCd8vewz5g40cIP
	 rDe14vhr8a+Bi3b7X2Mt80tBXFHcbEh3USsYhMVUkH1riimirC4aa6CcAKvXvxKrgIG2a
	 wDIrXx3cy07zbbOq1Wu5JhtwwY9jXFTqta6rga61vMA4+EDTjnOjAEAhv1RL6Ab+qxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SnaAXovy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637A5606A330;
	Thu,  5 Nov 2026 09:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SnaAXovy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF9AC1F000C1;
	Thu,  5 Nov 2026 09:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793871846;
	bh=cl0o/t0hLxvs36DJVBtguhBYlsrgjBilx1megG1I2r8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=SnaAXovy1H8UlqhL0W41aHdl7LU+iElNq4bVxi3JEp+eYu+inX6ZifHzwmwFhurW0
	 mZSu2awsd4OVHoDE5JwyccftaHI0wlWtuoWbjCT0UcSDxBR864H2/mTFCG+eh4a0Tx
	 xpm1MgB9bPGbn2Uzw1toqrmxpsnVkt5Yg4gb1fvLVsr5WhS1NQpenRe0Ks1yH0jpcM
	 rFRmv5OhAuAgH4GaAjVz45ZySGFBfTghyLX0PRQTJidSgisBZdIR1/qs8TtcDbd97v
	 hx4NoNODBMpCFp6oCvD/jEUE64r8cvnfZqOl8HysxFO5MbWTttyLkGRdKYZJvFtGCY
	 tnE6uNp+JF+6A==
From: David Hildenbrand <david@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Qi Xi <xiqi5703@163.com>
Cc: linux-mm@kvack.org, Zi Yan <ziy@nvidia.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Qiliang Yuan <odys.yuan@gmail.com>, 
 linux-kernel@vger.kernel.org, wangkefeng.wang@huawei.com, 
 sunnanyong@huawei.com, xiqi2@huawei.com, stable@vger.kernel.org
In-Reply-To: <20261103080557.1632382-1-xiqi5703@163.com>
References: <20261103080557.1632382-1-xiqi5703@163.com>
Subject: Re: [PATCH v2] mm/migrate: fix softlockup in do_pages_stat() with
 huge page arrays
Message-Id: <179387184168.13108.151326476173298230.b4-ty@b4>
Date: Thu, 05 Nov 2026 10:44:01 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0

On Tue, 03 Nov 2026 16:05:57 +0800, Qi Xi wrote:
> do_pages_stat() walks the user page array in 16-page chunks but never
> reschedules, so a huge nr_pages can hold a CPU past the watchdog
> threshold on non-preemptible kernels.  Add cond_resched() to the loop so
> long move_pages() node-query calls yield periodically.
> 
> With KASAN and function tracing enabled, a move_pages() node query
> (nodes == NULL) over 10 million page entries (~40GB of mapped memory)
> reproduces the softlockup on a 6.6-based arm64 kernel with
> CONFIG_PREEMPT_NONE=y.
> 
> [...]

Applied, thanks!

tree: mm/core.git
branch: migrate-7.5.misc

Applied patches will appear soon in mm-next, followed by linux-next.

Please report any outstanding bugs that were missed during review, so we
can either drop the patch series or decide how to fix it up.

It is encouraged to provide Acked-bys, Reviewed-bys, and Tested-bys even
though the patches have already been applied. If possible, patch trailers
will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. Further, this is not a guarantee that the
patches will go upstream. If in doubt, please check the listed branch.

[1/1] mm/migrate: fix softlockup in do_pages_stat() with huge page arrays
      https://git.kernel.org/mm/core/c/10f2ae9f

-- 
Cheers,

David

