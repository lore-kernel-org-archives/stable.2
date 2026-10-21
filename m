Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792607071;
	b=fpss2ODE5PZSLrIyYJl+wofuacfHZy9xaaidWxenZs8fDSlnb06M9H8tYYSXyAd2WdxI
	 K8MmS0leO7UxBd+C0WJFMG8VG8PFIapiKBsU4W3xEUkLn5I+toSTl7o3J+9fNa8hcJiVl
	 WY9gnSlIRbCjM/5NG3H0crs1/LXE5qIE7AmGgfLbWSWpam0s+btf6znwzFIZpaZ7JU1NX
	 eqvHgTM09n1wYgThrMZaAEc5KrrGXFU7Cq1MHzMKbdtqo/3Ah69QpcmQBRfmGSK2rjtXP
	 24NFRn9WidTPv7ARQXaJ5yliJyIr10bZT+/UEj1s22we4oVNZWwhvOBtyNNzNp2fMnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792607071;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=C8k+JbJNU5IGiHKVYYM+eJQgIjguwqcbHlYgMrCENwg=;
	b=fokJiU/Vx8UGMZ837YDadYruW7sHv0/t/wcB/KCGEsxi/jBBSfttSFpmXeNZBetns3Bp
	 /ddWwsSKfDupliSHs7sYsLN8MphGHACtIIE1DeThEhBi1xUcaLA6ecSdmEdSEFlDKLEbd
	 FkZJmpzSc+VNyrVtCbMjwB+Iagb6w73bcrdeCJeTtbDA0OlaJXVX5fscjak49GlCDOA11
	 1E1HucM/AhxkvLIICm0Ba6qyIOhL2s2EHt3PXK8v6BEErCEsNKydbs7vf93m4H/FRylyA
	 MvrpJ7xuJYi/mB5qLDU7b+5xwY6RPYz2KTVKW6mrLCSNDSuc0iyqqgJZGQho06sunng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GUcHk8EG;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3159606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 18:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3159606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GUcHk8EG
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3550c917fd3so1348396eec.0
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 11:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792607070; x=1793211870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C8k+JbJNU5IGiHKVYYM+eJQgIjguwqcbHlYgMrCENwg=;
        b=GUcHk8EGdW9iALfuUNV6i+ojsO6BzNoR66EmrjLsrEgDqIVVpJsC6mc/me/508QbaR
         5hGlOZ/Ite48vvaiYyvDH6wDS1BOGMx7nB0RtSnTJPkWExQOwnjZFpD9sp2WjbOG06qq
         S6qWcZ7z/aW+sChHoygj9nzAPIiR3/larwlogL0J+Q53c8qSSBlqr0boF8iWTS6XNKTo
         KgwFvZNjjFDBm2qjyDy9bQ+UOf5WOnRdBUsb7f5Oqk9tvvl1jwpL9nfEdkrzOYkxlcEj
         fzjZnuIrKl28dfJ9svUYcjjr6CiQU/jlYu42mdRlwutO93/xD+PBlBFdNGwHN+BW8Q99
         y7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792607070; x=1793211870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C8k+JbJNU5IGiHKVYYM+eJQgIjguwqcbHlYgMrCENwg=;
        b=talzHmJkDzcqFq1e7cTz2+WSeI1xnxdeSYIy6AfIH27qu7lVvHKj78BAprYU0RPwQG
         jSuGBmqd0t6u4nhhiVx58+AQgwXrY5H8YcQVQ//+Z6NB33iXHrsmwc4rhb8ssOKHHYTD
         HPRO/E5csYj7DxHQ+oKqNOE75SHQH05kUxjmSrkzeUCQBjYaPbV8xlbfb0blUk4XaqfK
         1lABeY9zIpXQXln32umpo8mDyjo/dBGzeXvMzw7usZDzIPgUbFBlNK9rHAMnjRS1Cm9f
         Zc206e+OqsrPkvsVUgJD9DbcThHI3Gv5ayP4PFzGPNEhkOn69ZGySBt0zgX6xImWajSO
         lK8Q==
X-Forwarded-Encrypted: i=1; AKwUvBy8b4l/+jYraiaUqOlM70Czo2UyHVRNTQwV0lCf2qbJwBu74pEn6B7mahd21l20iGxNso7CFh8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJP8KH0YQLjDyn9bJ/7CPy9KDsF2h4rRDzsAEwCXxQnoaolGZzr
	YXX349I0JHoKm2gvBcVbTHGj47On/S8JKClJjO6bHZFBUcfDJSoOk0fc
X-Gm-Gg: AYBFou19OR4NLd6FAFDHTBnFS1NvIEIAhcVdAP54Zd2Y075uZciIg3jmNYnHOMp1in5
	ToCzloqOL+cCJcQ/xiq6+9fhW2eVfFYzZvslSvP+9Kyt3tTUfYQoUH8HJGyEkwzM/wY/+7ethkF
	YH9GuXsp7dSwnZl50/axAw7IUOl04A2VCqp4xJQgNpRA4ckXgAzHK0dF4vqdl8DVW535lRlZfRP
	YaDgUC5X3hONYrGTqqUEXDbOG3ref/WuJA1jg3AcD4rY9gx71+iRmXEcHT/CVboNez9ylEKAc7e
	L6rmIexYbQQgiXltA583zDhAmpRhBcR4vmTNVpYe7qlI+VFnxwp3HOMkRp6JTCH80qZJ2/ljPJJ
	dGSPbFA6zpojEloJ6eMRbW/Uodv8DB5aVB3QPDXaLZNglitcxrHgVHiUFkfgEY4n3jTegeMTXLv
	TSnCzHlKXZidA6dskMgP/z+siW2mbB9rpa96KkiDKfqPcQPy2XtLa55zMdCA/wNFfmJQvdFyG8m
	1IscxFk+x1eMQDEkBWB6v7kBDYnyW2/V68Obl4tFc8G/WliP7HZa2AJM33ByyEW8n3a4JniSV4+
	GsPq0Tk3/gGfjmrqo9b+k2JqrP6ZVAAAHWThjA==
X-Received: by 2002:a05:693c:8399:10b0:35e:f1a5:9ba6 with SMTP id 5a478bee46e88-3674a40738emr4497258eec.5.1792607069610;
        Wed, 21 Oct 2026 11:24:29 -0700 (PDT)
Received: from 1u1g-b650-0212.nvidia.com ([72.25.70.131])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36740cca3d8sm9107228eec.14.2026.10.21.11.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 11:24:29 -0700 (PDT)
From: Samarth Narang <samarth.colleges@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Xu Xin <xu.xin@linux.dev>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Peter Xu <peterx@redhat.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Samarth Narang <samarth.colleges@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] mm/ksm: keep soft-dirty when merging a page
Date: Wed, 21 Oct 2026 11:21:57 -0700
Message-ID: <20261021182157.1873726-1-samarth.colleges@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

replace_page() maps the KSM page with a PTE built from scratch, so the
soft-dirty bit of the PTE it replaces is lost. A page written since
"clear_refs 4" then no longer shows as soft-dirty once it is merged, and
a soft-dirty based dumper treats it as unchanged.

Copy the soft-dirty bit from the original PTE to the new PTE.

Fixes: 0f8975ec4db2 ("mm: soft-dirty bits for user memory changes tracking")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>
---

Notes:
    v2: https://lore.kernel.org/all/20261019010934.697895-1-samarth.colleges@gmail.com/
    
    Changes since v2:
    - Keep only the soft-dirty fix, as David suggested; Lance will be handling
      the uffd-wp/RWP part.
    - Fixes tag reduced to the soft-dirty commit.
    - Dropped the Tested-by tag, since the patch changed.

 mm/ksm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/ksm.c b/mm/ksm.c
index dbfb8f98b189..910a1307ac9f 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1463,6 +1463,10 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 		dec_mm_counter(mm, MM_ANONPAGES);
 	}
 
+	/* Preserve soft-dirty when replacing the page. */
+	if (pte_soft_dirty(orig_pte))
+		newpte = pte_mksoft_dirty(newpte);
+
 	flush_cache_page(vma, addr, pte_pfn(ptep_get(ptep)));
 	/*
 	 * No need to notify as we are replacing a read only page with another

base-commit: fcec4f4bcc1101dbd7e3aff267856b3bbfe128c6
-- 
2.53.0

