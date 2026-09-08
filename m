Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066E043D4FD
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 10:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788864564; cv=none; b=H2SrpRR+2i7iSI/W4zseICglaYctgrIFnUa/FN7/p3wh634LgriKHEOsNwCnZ2xYyyL+V8uLWPZFmwi8JfgnpDqgu3FZGMYOpsQ9G6zMaqpvPp5k0N1pOJmaIzED1MA854uSRSqJ97zotzzodBy8u77vsBabuu73S14tUcpi6n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788864564; c=relaxed/simple;
	bh=Ne1vkINJENsZAMIm7hAepT/1OfoBokZdtmvNYXcq5Zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tl3EO+HA7zb5tcKUof3MCeyL0qNPSCbvPxGQtmUIKbKjd1U9YCkQEVeLfFwjsjxFzmJ6DPsNj23VwH+KcokFQOr7VDzodn7HvWopTYJIu47JCKCADlYH5AyrUsRpNYea2gtYHb2n2/HszjzkFy0FVI5KV0dvT1YWFS+noKqUKrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IGodmZvA; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGodmZvA"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc1cc1b42b5so4456986a12.2
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 03:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788864558; x=1789469358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H7Reb5/FkRfbcDYcZ4Sxy1Xn1C7+jIuC2a5ZFlPXPUA=;
        b=IGodmZvA8zHUdTKwjS1kH1/tdI+GBkIGUwbPGJ1iz1xKR30bpBK5+ZnPmU6RAf7KJC
         UVaihVdGHVUevZ5d0v90pcJ43/C8+PwEta8aXtJqzmaGLoow5lfOVgln00UrHF7wSayj
         t2YIqvk7kBas2d37cwU0Kl5XjjjxIeNG3UoWy9zBTh0hfYc5MdE3oktboM8/g4PTUVYg
         YottqO3WA872WAAM0k6OpPGuE4Kz3POcJCBpRqZvOQqy4/jthgfs7MRHCjqLqJu6BYRc
         wI8ibzH82a5aOrrafYZTVlYXvXSZn/Vi2MZwHtPk36HwEIcsuTYOugO8FKEJKGGLlwym
         XksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788864558; x=1789469358;
        h=content-transfer-encoding:mime-version:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H7Reb5/FkRfbcDYcZ4Sxy1Xn1C7+jIuC2a5ZFlPXPUA=;
        b=RzE6O13NIQ3HitiLuR3kG9gV7y+VH3Kf59KRzpV/DtV8HmYGiP3p6AnlYbOot5LAM9
         rnevoZu3xKMTUPBFWUPOittvKXbaP3lHtaYFV8TNRn+32u04Nte1Jzxl20s55gNAzIfd
         4hgp/EOalErAUqzPsejh+GOmhxL52Fx9VnCnhtRIrQEkJtX7i765zMetynwnlU5HQz6Y
         F8BbiLhTybONPxyUQFNuuEZ4RUy/2hTjTcIE1d/i3VeKN2DaE4+mbBNYqyDrsRa3DYJs
         cBNeQdUJuEteaJ0Z46PSrbMkNMEmePr7FOdaTbJSFhv7dnDHR954lMyO8ZfstG06BTad
         gUVQ==
X-Forwarded-Encrypted: i=1; AKwUvBxySCtBKAxKw90RMw21nDWZEktX5JqJoleEmLKm+9Z/UblE2T4Db+nBwXhcWHclzRjMRm11sUE=@vger.kernel.org
X-Gm-Message-State: AFuF++mqTktzf0sOO4KXiXEJRnYoOEDW8BfXK7YemQmoSiH6tfyIgT72
	6Hyw/58Zn6HmjWbyhqI11YkBI5+A0Dbtm/aYWL9vyoDqi9Byxckml2w=
X-Gm-Gg: AYBFou1NU6fAzJFOIibrHG8P6WXkqs/YVLXztYadpPsim7VbHWyex85445Gl0pWKhjh
	XRbDMfGUR6nU3qLHAmKV9YbJH1yi9qXhGQvTrNDwap1Brjwh45TvMYCusYN1SqD1gMfnvVPqmF/
	2NZ2kiHm9CJ1eBGF8oDu7YlLSUtyPeBo2mMJCrunO00e6nf14MdBn+dhe7DTUilujsz+7+gd79o
	RaTu3cPFdi0bkTubC07bC1vghCgAio4lvMz6I/wKLCNRXCY1crx0ce1YUhsK3bMxQCDYUBIKtPM
	ruNNI2pZozGp15NAR7rEE7+O+0i59mxbZNnepRUZlN6umL/vdSbWb+VNsDvyKjsRy4giojHCWi2
	uK19Ffkwl7bR7p7e9mz//ByeJTOYiX2z5qacITEM/I4mtq/kmziJ/ugeQ8uqirJUlZVs+T0sAp0
	MpAMfjQmYEp7nK5LPi/gFiYKmsVMGb1lB/xh7Rdw4oCBxzkuFRN4DyCwgj/VKByRNcFNHNVVm3T
	U6dUmUbhl82wi1ILDf5w0Xqy0k=
X-Received: by 2002:a17:90b:39ab:b0:398:9be8:ea68 with SMTP id 98e67ed59e1d1-39b261da75cmr43885301a91.21.1788864557719;
        Tue, 08 Sep 2026 03:49:17 -0700 (PDT)
Received: from MalHyuk.localdomain ([211.201.32.99])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260f64ecsm26116182a91.8.2026.09.08.03.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 03:49:17 -0700 (PDT)
From: "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>
To: christian.koenig@amd.com,
	phasta@kernel.org,
	tursulin@ursulin.net,
	matthew.brost@intel.com,
	dakr@kernel.org
Cc: Jonghyuk Kim <malhyuk97@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	mdaenzer@redhat.com,
	alessio.belle@imgtec.com,
	luigi.santivetti@imgtec.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a use-after-free
Date: Tue,  8 Sep 2026 19:49:10 +0900
Message-ID: <20260908104910.183638-1-malhyuk97@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <825c1f02-b9ad-4160-8e4b-53f2393a7bff@amd.com>
References: <20260904080618.2098450-1-malhyuk97@gmail.com> <20260904080618.2098450-2-malhyuk97@gmail.com> <f25f2a91-b72e-4392-ab53-c11ef60e0fe0@amd.com> <ee27d37269f609192cdfd7a217d9731d7dca04c8.camel@mailbox.org> <a41a35b8-c78b-4c18-af11-26374918f222@amd.com> <7e4497506bb051fd1c25ed54f88a8036084e779c.camel@mailbox.org> <81e51d72-d608-46d0-a986-390ecd6f468a@ursulin.net> <d3d2ae0ae55fb07780f643de9517f3668484575a.camel@mailbox.org> <47464619-890d-484f-986b-9a6c06cd89b0@ursulin.net> <c3434f0a80318390d183a3a2f8f8fb3ae71c9906.camel@mailbox.org> <2aa58eb8-a33f-45b9-8ee0-518d72160f41@ursulin.net> <206df2dad0c68b8c25862c74c0a8399940044af2.camel@mailbox.org> <fa12360b-2ccf-41c4-a158-84e34835c0e9@amd.com> <299ef4389875fe1333bb934edcece3bee5c5526b.camel@mailbox.org> <825c1f02-b9ad-4160-8e4b-53f2393a7bff@amd.com>
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 07/09/2026 17:21, Christian König wrote:
>> Maybe Jonghyuk can give your patch a test run and then we could use
>> it as a hot-fix to backport
> 
> Completely agree.

Ran 0001 on v7.3-rc1-99-g89a312991dc6 with the KUnit regression test from my
v4 3/3 (mock scheduler, KASAN, no hardware). Without it the test fails with

  BUG: KASAN: slab-use-after-free in drm_sched_fence_get_timeline_name+0x9c/0xb0

and with it applied it passes. Reverted and re-applied twice, same both times.

Tested-by: Jonghyuk Kim(MalHyuk) <malhyuk97@gmail.com>

Two things it doesn't cover: it's x86 only, so nothing about the load ordering
you discussed; and only the signaled case - for a fence exported before it
signals, get_timeline_name() is still reached and reads fence->sched->name.
I haven't tried to build that case.

Could you add a Reported-by for me when you post it? I'm happy to drop my
v4 1/3 in favour of this, and can respin the KUnit test standalone so the
fix lands with a regression test.

Thanks,
Jonghyuk
