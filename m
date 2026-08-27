Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDF130149F
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 02:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787798562; cv=none; b=etbAqEbgDR3MkEspH8U5n+2RaSwbM/jkRe3b8n+NUrr4oCywA/d4qLMHsFA+7k6I/Ka+Q8956+akcZVThV2VfO29YBiWHxRAoswvHzMaL9O8Gww87AA2VLMW/ccL/uTnQz2O3TlxGtu4TVw3MaKv172mowM/4SCodnfVl3R6nPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787798562; c=relaxed/simple;
	bh=3yR1F6BTQPpbwdc5QIQK+grUD3F+EAAG+HlcztscTOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IaF4Ot3F5EEtj1DMvIbYSORtE6Pf8Qlv/VulmOzD5dkYZKxYh8tqUwNNE3SqKtRITPXix5Fqkm5v7jYHphzzBUr9ajrwR7sNNZaNLR34YQP5WYUeIdOSpV3592cWXEP2odo04APbKL4vRwfG89dEU4pBRPuqZm/0kdBjF6YmAD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anthonyvardaro.com; spf=none smtp.mailfrom=anthonyvardaro.com; dkim=pass (2048-bit key) header.d=anthonyvardaro-com.20251104.gappssmtp.com header.i=@anthonyvardaro-com.20251104.gappssmtp.com header.b=yYWJ1uiF; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anthonyvardaro.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=anthonyvardaro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=anthonyvardaro-com.20251104.gappssmtp.com header.i=@anthonyvardaro-com.20251104.gappssmtp.com header.b="yYWJ1uiF"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38511175ad3so237227a91.2
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 19:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anthonyvardaro-com.20251104.gappssmtp.com; s=20251104; t=1787798560; x=1788403360; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3yR1F6BTQPpbwdc5QIQK+grUD3F+EAAG+HlcztscTOs=;
        b=yYWJ1uiFqGKwrgz+u3j41c66Oot5aGwZH7HzkcsZVBmOloj/oFXs7jpHJ4USzf3BTY
         FNL0yoKUNdHt3lRo2gUixQQjX/SAmkjy9ou0l0E4cOaOzrYFHB8anjDfzsdiyk1FXnTq
         PAAUKmyc4thgl9oLbqK7tyrij0i5Odk7Tx9fEJi1fFpeCG6ajTaAOm2vak0lshEVcrdu
         /1xwnD1Ce8EqR6hpSsiCTgfEhUibJqiyLNrHenLmTsLp9zUyoir4vMi4GjYpNo0XYY1t
         2TGiwv9CeKj1Uauamie1SxDKZER/6abKzOpgepILdC9VqXXXct1vf9++3eCOVsDTb2sp
         7T3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787798560; x=1788403360;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3yR1F6BTQPpbwdc5QIQK+grUD3F+EAAG+HlcztscTOs=;
        b=ALhl2BrW7SDy22tk2r695zIbturz+geYB8ngsFrfazatGSbBpxVJODZybztYbSKNB0
         jQHkIaZwzGLuEZ6zrItmMUyASA4LjdCEpFAdsCCrO4hVMqdWst7CUA7Z7VTgm/wj7EO3
         Wzbf753hGrSw+QzkYAoTbtojSWhIK6rZFIeufAE73XSjLpLbjhs3eJPhErm2b8GaQSoo
         5FCf2mG1+l+iLHg3jWZJybRG/g4pfj1xflzWqhIjXASQOfzwTDwJ65yfsLRqo3MjBsYT
         0QwlW1Kc9CLka+ZNE02WXtl+m7nKdWcKgyYQu+S7G+/EHaBoc6WAmS7AGfw29gyN+iDX
         T5Sw==
X-Forwarded-Encrypted: i=1; AHgh+RqIVjHmCX8kriqYw/l7JPUCaTMD/kPkuLxfdQ1RN/UGBXqRglIa2Y+Q3IeB5nJd8rFeeheHhfE=@vger.kernel.org
X-Gm-Message-State: AFuF++nW+kjPjSAA/9vBlPXl77aywOlQowlsGmD5983LbmQlughfiSBL
	7DjfG6w+cJjc42jsI9gsjrwugV3rJCgD/GiQR89nEg7GCxZ72tLS8xDfQ5C0G9rSsYY=
X-Gm-Gg: AR+sD10EDTcq0jCCb3vd/HNa9TQM7gKPwPshgUitwlfdDIox0ICv7JDBwg55oYgOFUn
	km1R/WYtPmZodZCerIQj35nPkNANPB8w9zrWIS3EBiTMavE0Ikl0GeQd1t9bitfwZ4gVsWHKdBE
	YXvh4t94ctYQiJDEXHYoBkxmqxBpKf8fSCKKtX8FN2udtjElYoGJrDRYN3uIravYIxME+aaqpsl
	gwsjIeh24knIaMlBGb0SivOXJwrms4lWUHwe35b2DjgG89CBCGDnN1QoohDXKIqdMDFd3fVf1yr
	goB0/x0KLu38Bi/XQP/0lX1fJpP2fHP3hWEk9Oq7Uotj92y6FqNetwb1RoihJT9QzDFuVMHwhl8
	T6d3ANjDCfpxLtniBbIX1xHCPDku3sJgM5aNSfbkLycls4/Oe3R29TkaqbnFE6qDFc8OrlpaZMA
	4kULw7a3XHPLccQyBrEPmNEllE5AaUOO7xeZePmgASPDi2USD1mobUkgfEH8cInBKgclTg3eV2f
	DR4JhHWXsNI1Clq1Sr6+oF3MQZD95nJ0jnvU0Ctr3CjXNWxU65pla/s5zUjkPiQmNL1IMZymHQv
	ZEnieFqFUjM8acBNGoa5e1f5WH9zomSdANOeWvKwoT0MaQQEzm/Ui7+Sz+GRHg==
X-Received: by 2002:a17:90b:554c:b0:38e:1497:af5b with SMTP id 98e67ed59e1d1-3966d1396famr25274711a91.1.1787798560279;
        Wed, 26 Aug 2026 19:42:40 -0700 (PDT)
Received: from coder-vardaro-vardaro-2-0.tail2dda0.ts.net (ec2-16-145-69-213.us-west-2.compute.amazonaws.com. [16.145.69.213])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fa2f46sm701617a91.9.2026.08.26.19.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 19:42:39 -0700 (PDT)
From: "Anthony Vardaro (Anthropic)" <me@anthonyvardaro.com>
To: Dave Chinner <dgc@kernel.org>
Cc: "Anthony Vardaro (Anthropic)" <me@anthonyvardaro.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] xfs: revalidate cached COW fork mappings during writeback
Date: Thu, 27 Aug 2026 02:42:04 +0000
Message-ID: <20260827024204.197650-1-me@anthonyvardaro.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <aojPFYhD4SNPv30o@dread>
References: <20260820-b4-xfs-cow-wb-revalidate-v1-1-8a19080799ea@anthonyvardaro.com> <20260820161123.GH6072@frogsfrogsfrogs> <aojPFYhD4SNPv30o@dread>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Sat, Aug 22, 2026 at 08:20:05AM +1000, Dave Chinner wrote:
> Have you reproduced this and tested that it the change actually
> fixes the supposed bug?

Thank you for the feedback. I have, on 6.18.y and on current for-next
(412f89fb3988). The reproducer is a small C program that makes a reflink
clone whose size isn't cowextsize aligned, dirty a few dozen blocks so
the COW reservation gets rounded out past EOF, then start one background
pass with sync_file_range(). Once the pass has converted the first folio
and cached the mapping, close the first writable fd (or truncate to the
current size), which trims the post-EOF COW blocks, and append one
block. The pass gets to the new folio, xfs_imap_valid() is happy with
the cached mapping on range alone, and the append lands in the extent
that was just freed. After fsync and FADV_DONTNEED the block reads back
as zeroes and GETBMAPX still shows delalloc there.

With the wb_delay_ms errortag widening the gap between
xfs_map_blocks() calls it hits 25/25; in a tight loop with no
injection, 200/200; those two I ran on both trees. On 6.18.y I also
ran it with nothing but the periodic flusher, about 2%, and a variant
that lets a second file pick up the freed block first, which ends with
that file holding my appended data 4/4. With the patch every one of
those is 0/N, and xfs_wb_cow_iomap_invalid fires where the hit used
to be. I'll put the program in the v2 cover letter and turn it into
an fstests case next to xfs/558.

> So, before a fix is made, we need to decide what the correct
> behaviour is for writeback on mixed mode inodes. Given the imapct of
> getting this wrong, I think that should be unconditionally tossing
> the cached iomap if either the cow fork or data fork changes.

That works for me. I also agree xfs_iomap_inode_sequence() as it
stands would quietly drop the COW check on data fork mappings, and
you're right that the data fork path never samples cow_seq, so that
check can only ever fail today.

So for v2, xfs_map_blocks() samples both if_seq values under the
ILOCK_SHARED it already takes for the lookups, and only stores them
alongside the mapping they were taken for; xfs_imap_valid() throws out
any cached mapping, shared or not, if either one has moved. I'd keep
the private data_seq/cow_seq for now so it backports cleanly. A cookie
could replace them later but it would have to carry both forks
unconditionally.

Since that makes COW mappings revalidate a lot more often, I'd like to
add a second patch that maps an already-real COW extent right there
under ILOCK_SHARED rather than bouncing through
xfs_bmapi_convert_delalloc() and cancelling a transaction, which is
more or less what xfs_map_cow() did before the writeback rework
removed it. Does that line up with what you had in mind?

Anthony
