Received: from mta0.migadu.com (out-116.mta0.migadu.com [91.218.175.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361914457AF
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 09:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791625362; cv=none; b=ITUF/jMNriihUMQMugqMwxt3dbs0HfUFMmHxQgwBf4wBr1S2VV7S0mp4krPAFFriDt58d76vmTBsTDruCcscCHqDNpJjT8OkhhkSh0R31becyZXTZaa8knL46rrIgbATaBsJOPf72BgLGCMQbd2OCNsQYYynniEX4tGGJMBSSpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791625362; c=relaxed/simple;
	bh=AYKq4I4pt+XRaSTHkcogaEaoukmbVRkhJcniZ//zAgg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=UVMs5/8gbZCTbQW+qJjWcJpUtfqbPWfr+zj4DNB2yk/8rSSdJwA/X0ASCJkWtmFuG9Sbm8USa+ew/x+UjIBegTCJy5AjH/slcLEhW5ccSYb+vzcN4UtR5C4wO0crvjJUrJ+zFxduJOq8MsvS0u+RcTZnPdu0O5xfRKv5rnwUKvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JH8jotTN; arc=none smtp.client-ip=91.218.175.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JH8jotTN"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=AYKq4I4pt+XRaSTHkcogaEaoukmbVRkhJcniZ//zAgg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791625354; v=1; x=1792230154;
 b=JH8jotTN8PT2QTxlydeHuspWguhlCpn278sbtRghB5i4vNMAe9BAO5Kq9FRX5oqjZh57Q0nT
 8AwiglyrzCqiKsk7JUCVj6dAM0o9QayTCan01lqCItUOxWJTt6c00vrxz3b4jmd/tGz0xJTlanD
 m5UtxLQ80OZPYWhA7IlqSYos=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 57f0757703d8e229;
	Sat, 10 Oct 2026 09:42:34 +0000
X-Mizu-Trace-ID: 57f0757703d8e229
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH 0/4] mm: Fix page-table teardown during memory hot-remove
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <b62aa96d-6c83-476c-bc28-7c2057702063@intel.com>
Date: Sat, 10 Oct 2026 17:42:18 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 akpm@linux-foundation.org,
 linux-mm@kvack.org,
 stable@vger.kernel.org,
 david@kernel.org,
 osalvador@suse.de,
 dave.hansen@linux.intel.com,
 luto@kernel.org,
 peterz@infradead.org,
 tglx@kernel.org,
 mingo@redhat.com,
 bp@alien8.de,
 x86@kernel.org,
 hpa@zytor.com,
 catalin.marinas@arm.com,
 will@kernel.org,
 mark.rutland@arm.com,
 linux-arm-kernel@lists.infradead.org,
 pjw@kernel.org,
 palmer@dabbelt.com,
 aou@eecs.berkeley.edu,
 alex@ghiti.fr,
 linux-riscv@lists.infradead.org,
 agordeev@linux.ibm.com,
 kevin.brodsky@arm.com,
 bjorn@rivosinc.com,
 apopple@nvidia.com,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <D9A15D57-0640-45AC-B404-13982B4A20B1@linux.dev>
References: <20261008073021.2512665-1-songmuchun@bytedance.com>
 <b62aa96d-6c83-476c-bc28-7c2057702063@intel.com>
To: Dave Hansen <dave.hansen@intel.com>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 10, 2026, at 04:48, Dave Hansen <dave.hansen@intel.com> wrote:
> 
> On 10/8/26 00:30, Muchun Song wrote:
>> This series is limited to bug fixes for the existing teardown paths.
> 
> Why is this a series? Why not send the architectures independently? Is
> there some dependency where they all need to be applied at once? What do
> you want done with this series? Are you expecting it to be merged via
> the mm path or the individual arch maintainers?

You're right that there is no strict dependency across all three
architectures in v1.

I grouped them because they address the same page-table
constructor/destructor imbalance exposed during memory hot-remove, but
that alone does not require them to be applied as one series.

For v2, I will move the common destructor handling into
pagetable_free() as suggested by David. The RISC-V and arm64 fixes will
then depend on that common MM change, so I plan to keep them in one
series and have it go through the MM tree, with review or acks from
the relevant architecture maintainers.

Thanks,
Muchun

