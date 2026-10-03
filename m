Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA68E54B
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 22:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791067812; cv=none; b=hzjoNf6mAkkk45cHYEOZ5F5dc7CIZc3JGizVz+MgRnI0b7n1CkgDbA9AlFAOfE/TMIvXPtiO0XHEk9LiG1AQrcfgN/9EJOl3jqV4RKoSXkOFo3pEeM6UaBKspjR2XcF3kQjOEeIEk+cl96EKB36p76uR1BiZYMaMSrOvecbadpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791067812; c=relaxed/simple;
	bh=Ln+Azr7HK2EXQEptTDhG0BbitoBWSxq4Kg02LgI222c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XTebiI7P7Trjz3hM0Yy4Jpwtsu9HoNuG8Uge38DGjg3L4iVOry5W7CAG+3gxm8iucU6QWihOZlx0H9W+hC6HxvYzqw00oKLUmbAw2doS2rX8/Q4u1uSE13U91DI/qUgQhtnWeQBJGVNqipsaFPULH5Zl4sCWtPiJehG5q7aazjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h55L5dCX; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h55L5dCX"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e46a15703so625374eec.0
        for <stable@vger.kernel.org>; Sat, 03 Oct 2026 15:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791067810; x=1791672610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LZL+tSKElyr0AUFsinzmRr5UN/djSQukFYuYztshUAk=;
        b=h55L5dCXTPm6ShMp+X06sEsBM2F7N5tNpA64U6QjymQajOFvvm+Nqt7v1L/wyZ1ski
         eRvvEJb+Ey6DRZO3u28C7wgeCF8/S2pZFB3BumzKBlM6sgfKiSF69tVTHfQ2Ut9sLmyD
         rRDvEZzGnwndwYBzFq8vqXce4f9o7acITEdr7cuL1EyfBuZDlYwWASnYZQEyRwYM7OAS
         FEUWF40+Blc/LTXUrr6O49N6DtL9tuDrgf+PS4qbmPACFFLEffjvoQIL4+EBJWJrF2zx
         S5okVQXBKDk94i5MdRIVCk0oFgaiQoh0yyS80YlCvZ1bJPoKVizXCTayag1Sy3UGQQPZ
         em8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791067810; x=1791672610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LZL+tSKElyr0AUFsinzmRr5UN/djSQukFYuYztshUAk=;
        b=W+b3OXgd+5rY/SiqUV2/GY09Ic05/tezpNbD/qyDKaH6SyWTqd0FLH6xnh2+hH4hgf
         HJz/a/r0qzK8oK/SoThcgiZeyknze6Fx1OzOsJawzkwN/+4wBtSb/BCljL8xF9rfFJwN
         NYKfTXbb6hzVH7DlQdqRiW4pib2eiuusDLmC4gufG0tXioy/HQBOnbNRtJRWSwon3pD1
         mCEte+58BPZTFfZTsmOLLIHXhJkzItKkYZuQRLdahmVsuRPSRaALkIuziCEpExuffzM+
         IJSeypZXsvBXQenffF9TNWLeSb0lfIpPQxsvenXClQilSxg24/JRRQ35hwFyA0AyN9iS
         DGeQ==
X-Forwarded-Encrypted: i=1; AKwUvBwSlKmhnTliQRg/YLuGynnK04g6MGxQic74lbk9EiWcOTqhPJSsmAsuw++dpQAvnBrRimHWFMs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIzZRWNrEeirbEEKBij3y3y7B3qYrOuW9B8RLYMyDdfk/INhsKK
	l5z70urBy4qz3tybjVkj3RZPdJTHadkff7HQ3kSAIU4qMwhbxCnHYzIi
X-Gm-Gg: AYBFou3Cgq6e02qmBuZ0hnvzE60+6648+j+prA4IYow6XtSDm0rIE4SuAurVJvrVmaz
	s1Jor6MYld6IYplflES/xB6AvdKMKSrPFgshfgNMOQxPICY/XySo2rBDxGRHIJflmj47AyvqS3l
	ror5YDYXSCYY/wf0Q9X7cQCO4n0FMX3a6x+3MPE3ix9qSg/TO4wNzQpqlFaTRZOcVK0AbKpnhK6
	2NF38dt/OuOgW96A/312sG4/XfJN+ju5jOG6Jxw2cgIyPBUn8O1cNn+vVEbBHL1Q/1W+XLD4ZI1
	AZCPizMsTiu/n/K6nPPS2PTjyPd0YSxBu1/O7YY6viFtCq2XzUlB3q3FuC4wph2S1AlrYJE6gsw
	8nl9UdQOsgwRBZDO4dfzGZEHXEIdlqiSESosUhHBiMF1oZykjP1SvCq5oh63Qm7niJSe5eFgPq2
	0gkcEZgeQZfJlLhbw380DQTHLw6vYdicuc5RpP0A3I8tH0CsYGMJ3c7iqoRBZ0PZLHIsW4omh+n
	HuAeSO0q9x3RRY20IvYBAQ7IHSrPBFzJVkwcOoLqNGsZithNdgnTUwhRR3BoQ==
X-Received: by 2002:a05:693c:87c6:10b0:343:4a95:f120 with SMTP id 5a478bee46e88-34f152d8ea9mr7606205eec.25.1791067809905;
        Sat, 03 Oct 2026 15:50:09 -0700 (PDT)
Received: from s1lverbox.orsomething.local (47-144-201-183.lsan.ca.frontiernet.net. [47.144.201.183])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3511d87cfa7sm5036648eec.26.2026.10.03.15.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 15:50:09 -0700 (PDT)
From: Jean-Paul Sergent <jpsergent@gmail.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Jean-Paul Sergent <jpsergent@gmail.com>,
	netdev@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: dst_metadata: fix fortify trap + overread in skb_metadata_dst_cmp
Date: Sat,  3 Oct 2026 15:50:08 -0700
Message-ID: <20261003225008.1634351-1-jpsergent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <787c2c1e-1260-43ae-bee0-9798e1e53c2b@ovn.org>
References: <20261003005449.2675.1@jpsergent.gmail.com> <20261003005449.2675.3@jpsergent.gmail.com> <787c2c1e-1260-43ae-bee0-9798e1e53c2b@ovn.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Oct 03, 2026 at 03:31:07PM +0200, Ilya Maximets wrote:
> On 10/3/26 3:24 AM, Jean-Paul Sergent wrote:
> > memcmp: detected buffer overflow: 108 byte read of buffer size 96
> > ...
> > Geneve carries 108 bytes of options, and the combined struct+options
> > memcmp trips CONFIG_FORTIFY_SOURCE when built with clang. ...
> 
> This doesn't make sense to me.  The problem in tun_dst_unclone was
> at the initialization time, where we couldn't write the options_len
> together with the options while the currently stored value is zero.
> 
> Here the function just compares two blocks and they must be already
> fully initialized and have options_len properly set.  If they have
> options, but the length is zero, that's a bug somewhere else.

Thank you for the review, and I apologize for the noise. You are
completely right on this. I re-tested the case properly with a userspace
test mimicking the FORTIFY_SOURCE check (clang __builtin_dynamic_object_size
on a __counted_by flexible array matching ip_tunnel_info geometry: 96-byte
struct, options at offset 96):

  - Equal options_len (12/12): compiler bound 108, memcmp length 108 ->
    no trip.
  - Unequal options_len (12/0): compiler bound 96, memcmp length 108 ->
    trips with the exact reported message: "108 byte read of buffer size 96".
  - Same unequal case under ASan: real heap-buffer-overflow, READ of size
    108 past b's 96-byte allocation.

So my initial "false positive at allocation time" theory was completely
wrong. The metadata is fully initialized at comparison time, the trip
happens because of unequal options_len, and the out-of-bounds read past
b's allocation is real.

> > While here, fix a related overread: the memcmp length uses
> > a->u.tun_info.options_len for BOTH sides, so when b carries fewer
> > options than a the comparison reads past b's allocation. Pre-check
> > that both sides carry the same options_len
> 
> This makes sense and may be the real bug here?  If options actually
> have different length for some reason, then the memcmp will rightly
> trigger the fortification check as it should.
> 
> However, someone more familiar with GRO should probably look at this
> to see how the comparison should behave when options are different as
> it sounds a little weird that they are.

Yes, this unequal options_len overread is the real bug.

Regarding GRO behavior: in v3 I kept the original pre-2017 semantics
(unequal options_len -> return 1, no aggregation). Aggregating skbs
with differing tunnel options would drop one packet's options, so
rejecting aggregation seems right. I have CC'd the GRO and networking
maintainers to weigh in.

We are also investigating why the two skbs have differing options_len in
our Cilium geneve setup in the first place, but regardless of the cause,
the comparison helper must not overread past b's buffer.

> > and compare the options
> > through ip_tunnel_info_opts() so the counted_by view matches the read
> > length (the same two-stage shape the unclone fix uses).
> 
> This makes no sense.  Single memcmp should work just fine as long as the
> compared size doesn't exceed the actual size of both memory regions.
> 
> Do you still see the fortification issue trigger with just the length
> comparison change?

No, the fortification issue does not trigger with just the length check.
With equal lengths, the compiler bound tracks the allocation and the
single memcmp is completely fine.

v3 drops the two-stage compare entirely and restores the options_len
check before the memcmp.

> > Fixes: 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
> 
> This is likely wrong and should point to the commit that added the
> tunnel info comparison.

Right again. Git history shows that the options_len equality check was
present in the original GRO lightweight tunnel support (commit
ce87fc6ce3f9, "gro: Make GRO aware of lightweight tunnels", 2016), but
was inadvertently dropped when commit 3fcece12bc1b ("net: store
port/representator id in metadata_dst", 2017) switched to a metadata_type
enum.

v3 uses:
Fixes: 3fcece12bc1b ("net: store port/representator id in metadata_dst")

> > Cc: stable@vger.kernel.org
> > Reported-by: Jean-Paul Sergent <jpsergent@gmail.com>
> 
> If you are the author you need a sign-off instead of a reported-by.
> 
> Also, you're missing a lot of maintainers in the Cc list.

Fixed. Added Signed-off-by and dropped Reported-by. Maintainers from
get_maintainer.pl have been added to the Cc list.

> > Closes: https://lore.kernel.org/netdev/20261003005449.2675.1@jpsergent.gmail.com/
> 
> There is no point linking the same thread where you're posting a patch,
> it will be linked anyway on commit.

Dropped the Closes: tag.

> > Assisted-by: LLM
> > 
> > v2: fix subject prefix to [PATCH net]; no code changes.
> 
> This should not be in the commit message.  Also, there should be a link
> to the previous version here.

Moved the changelog below the '---' line with lore links to previous
versions.

> > +		/* Options lengths must match, or the options memcmp below
> > +		 * would read past b's allocation when b carries fewer
> > +		 * options than a.
> > +		 */
> 
> This is obvious, drop the comment.
> 
> > +		/* Compare the options through the flex-array member so the
> ...
> 
> This part of the change doesn't make much sense, but anyway, when asking
> LLMs to write comments, please ask them to be concise.  There is too much
> stuff in there that makes no sense in the context of the code, e.g. the
> mentioning of the "tun_dst_unclone fix", and the comment is generally way
> too long for what it tries to accomplish.  It should be 2 lines at most
> in this particular case.
> 
> Same applies to the commit message, there is too much fluff in there that
> makes it harder to read.
> 
> So, please, do some quality control before sending patches, read what
> you're sending.  Don't just shoot out AI slop.  Next person may not be
> that kind in their replies.

Point taken, and my sincere apologies. The criticism is entirely fair.
I took an unverified explanation at face value and skipped the build
testing I should have done.

For v3:
  - Both comments and the two-stage compare are gone; the fix is a simple
    options_len equality check before the memcmp.
  - The commit message is rewritten and concise.
  - Build-tested locally against net/core/gro.o with clang 22 and
    CONFIG_FORTIFY_SOURCE=y (the affected system's kernel config).
  - In accordance with netdev rules, I will observe the 24-hour waiting
    period from v2 before posting the v3 patch series in a separate thread.

Thanks again for the thorough review.

-- 
Jean-Paul Sergent
