Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795256364;
	b=ciiR6IS9/YQIwErdhq1jpq7+vBQXMNQCvraGfM1DmI4Gf2Lz3RFfjLj9ADGvcgGxXtWn
	 SyBtrDsh2tOcABBWx4ugGLHvIglO/6D6aLttZV3do3zUL8t46i6BybqQPI2wJzRiRLM5o
	 sLCYvS7rA4PbFzwS/F6fYrWSmdoVngH5llPzcJmEH5TQulTxCfE5eiAZ9c0rZs6N39fHm
	 uGCtZx5nTQoMGQkV1qenQI6xLLnHnX66M1WtBqKlGd0EMKIUuO6zY1fOIYDA0V8yv527q
	 5LRz5YoYuj9bFEimlMR+TDf3DoG41lqRIyMFi57eGOyNvxYtUKOwH/SCm4WfMlJv67A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795256364;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=N9CIh5H4VwprN8NFJCHt7BtCzMbNAPuxvGffemDSkdo=;
	b=n3G+/b4vIzm8OSywmPkyPlrCOWejrnfGoMN3G2Cuc8fTdLunVn+NC03ulBEziZhnVHYW
	 WfYs44tl8KtcMT+H6Id2DDpT/C5b/IDkm/jjnkyhXa4f6DJNgvbQwLUnRWcMA8h/N+Ha2
	 iA0iSqs2ogDsBWPUwAoRdETajeyawIuXYkPX9y5MZzExq5QfZWOaZZ/LfaDCDGPbCJ+Bd
	 LvcsKVoQsB/AXQKHC5wzV1QVZfZIJgykMDBPHOovY+CPIGX6dDQHddjSpQyJ0+trVE9/W
	 ezUqtGYOBJ+zlVNlPiqNoqb1XrCLCvhd3DKZs2cL2q99QVMxXvFNEUzQ6obWxzVeRzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=hoiEimoX;
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5EA606A320
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 10:19:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB5EA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=hoiEimoX
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-9213922de73so28279286d6.1
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 02:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1795256363; x=1795861163; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N9CIh5H4VwprN8NFJCHt7BtCzMbNAPuxvGffemDSkdo=;
        b=hoiEimoX408yjyDFycIzfZlVs0ZY1gTa9U7w/ErM8fupedSMctB3kNZr+vbp4eeGhu
         VRqjWyuIZkRRdQGOeKgJU1KWPhRwjBFZydw6/VOXUeNmgTiqNWNV29OjFKEjVTgPoF0Z
         nXvZZYtCC9EqKLdLrwkB5+zpoyCbmRQ6Y8nV3PKurhfMgup6cX12tEDRTdZ64LFKU7rf
         evSNyKtt7qb9NVT/YyLQvo02uZ1IXMWHSJmpCl9pd3In7+oLwbjipmEn/T3wuhI8dXHQ
         yDTOH09PePQ9XLaAbQo+ks7dsmGyspYKwigVaH7CRBrxGYuzVraM6+bwYrQWBq4/gDqP
         rNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795256363; x=1795861163;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N9CIh5H4VwprN8NFJCHt7BtCzMbNAPuxvGffemDSkdo=;
        b=bi157WdtxmX2uZKvOLMgSrswVlvcYAlzLHPBtET37BE4hRG5E5+BdFJ7YfSJF2KVU2
         ezaKkgXKqj8AxVRKKSpvwLS1AbPNa0tdl2INIUufWt1/0PiKauD0iAMVnx4EmHuARXfv
         rsj8Mo1Veaz4GCvpiC1Pr45CwR8DbWtbmSjHBQs3rpH+14XeA85hd+3WHvAiEVBinIjK
         KANOe32U1aarb9xJoJ63+iFOAFgyttv4sdyIz4lkcR7hMo8TU1SN3z1/IfjF4JkRRAai
         jagV2idJZMsIDXAz3zNp6A5vusDauz31INf/fuc7HfkNPTyguHDAfTClNQ/w5ibzExyk
         peBQ==
X-Forwarded-Encrypted: i=1; AL+hErHeXYeWkigb8u9FpJ91vJbiYJyR+66ZKF249YCuLb1K5WoHypGmPHW25JDAx3YzbBMM8sJ86i8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ib9VuOqLhh7r60B68Ck+AB64BjchN5O/Rl8qlg/xD5ITwgGgX
	B9BPu095e1Q+U4/gRkxRAbYNJn6WyI2sYUMag2NJMS74b5Wf0RVek8dSALfrBwBhEJRPy2PEB51
	boys=
X-Gm-Gg: AZFdTZcifb6msgJWU6EQznoIby/Kw4LlRvUlgWclAVxrkx5sUdzvIV978Q2TxC4llRR
	RHGqUoUpuEvGEHiaUs27ptqLZyoouI8b/jR99tFBnpiLhXXkg4EGBtGb7IdNKJ9+N0W94rTcLI1
	P/yEvfcTOJaw1pyZsqcX6OGzD4eBhlUipRUjpMwI6sr+wBrGlMWehqfA4Q7YVoqXZ9ll4B9I3mn
	w3cXUvSemHqhtu4ArD3t5d4szpFB8AzRoDBeNEDIoSSOT0/lPx90zh0Q+5AmZlTQq3lrm4piHDr
	y/BzVfr1HCkds7d1nqy9JMCw3vf9HGZpHEUCq6s+DHrrHIRRVk/CcPqHHqV3vFqCU3dScOcfMWo
	BFzVTQ3BZf9bbM5cluMnlwBN6zAEK+e5V4ayEf1qJ1bi1aPoKnqdXvaD59lYMvZROD6zswPIzbe
	y6Hl9WzU6nYDsPuqNYuDdzTcXOq+qvJXHr3pTVWruwywFvgXUZQnwiK+Ls7lp9GQmkWX7Use5xa
	uyHjcjd0g+0yo4tv0ao4QaGibuSBx3S8/XmjB4oG+4W7cfeO+9Dc3bdG5Kkpij4aJ/9uSoj97TP
	GCK0UnXhGt3vDNjH35nyBG3+XXvF/39M/RVynUnres0JMh2Yt60=
X-Received: by 2002:a05:620a:601b:b0:949:76ed:591f with SMTP id af79cd13be357-949ba82851fmr949300985a.8.1795256362690;
        Sat, 21 Nov 2026 02:19:22 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb35005dsm393964485a.11.2026.11.21.02.19.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 02:19:22 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: slava@dubeyko.com
Cc: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] hfs: avoid reusing occupied CNIDs after deletion
Date: Sat, 21 Nov 2026 05:19:17 -0500
Message-ID: <20261121101918.3395879-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <f59ea6b2a8c60594361ab596d92bdf98a217dd83.camel@dubeyko.com>
References: <20261112110128.4082071-1-hengyul@cs.unc.edu> <2bbc10eb1dd5ee69329a9307f14fd15b1815b898.camel@dubeyko.com> <20261113194103.3825961-1-hengyul@cs.unc.edu> <f59ea6b2a8c60594361ab596d92bdf98a217dd83.camel@dubeyko.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Slava,

Sorry for the late reply. I have an important deadline in early
December, so I may be slow to reply until then.

On Mon, 2026-11-16 at 15:21 -0800, Viacheslav Dubeyko wrote:
> You explained a simple case. :) My worry was about the case when we
> could delete some number of items between [16, 20]. For example, we
> delete 17, 18, and 19 at first. And now we delete item with #20. So,
> leaf A should have 16 as a maximum CNID. And we can use 17 as a
> next_id. Correct?

Correct. I ran this case with the patch on a fresh volume. Creating
a, c, e, b, d gives CNIDs 16 to 20 in three leaves:

  leaf 1: root folder (2), thread of 2, a (16), b (19)   max 19
  leaf 2: c (17), d (20), e (18)                         max 20
  leaf 4: threads of 16 to 20                            no file or folder

  rm c (17), rm e (18): not the newest CNID, next_id stays 21;
                        leaf maximums 19 and 20 stay
  rm b (19):            leaf 1's maximum has to be recomputed, the
                        root keeps 20 (from leaf 2)
  rm d (20):            leaf 2 is now empty and goes away, the root's
                        maximum has to be recomputed: leaf 1 -> 16,
                        root -> 16, next_id = 17

The next new file gets CNID 17. I checked it three ways: with the
values cached before the deletes, with nothing cached yet, and with a
remount between the creates and the deletes. A debug build that
compares every cached value with the records after each insert and
remove found no mismatch.

A larger case: 2000 files created in shuffled name order, so the
CNIDs are spread over the leaves. Deleting CNIDs 1916..2014 first and
then 2015 gives next_id 1916, and the next file gets 1916. Without the
patch the same steps end with "File exists". fsck.hfs reports all
images as OK.

Thanks,
Hengyu
