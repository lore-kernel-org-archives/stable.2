Received: from mail-wr2-f28.google.com (mail-wr2-f28.google.com [74.125.225.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6AA4477E8
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 09:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790241179; cv=none; b=pe/58HJ7oEmskn12vvQZh5+cXay2TbfpvTWE457P6pd5x9X5l9IIVme6oITbJ5O4vkzNxQl3c+lFnfW2KQDpaDhf34JTjCXijMMXModgM4+8sjZr9/P20RSWbHL2sfMJE7kYbq+qpFFy9cjckmlC8snTIQivJKlTACPVYtnbOSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790241179; c=relaxed/simple;
	bh=gbD38OZ+K8pV/KQl4DgCWHt3UcaEpwGclj1C9Ynx0P8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lL6dGPALJD6f4y1FGVwcELjzl+3evfj3xbMlfYEkQy9TiO+eeSo09dd2nqVMlOBaxsR2ttQ7A2DKQr34IALgTYfbv4U5fXVb5GAT3oTdlTftBtAnBNgRDpJ/D2Uu1agpejN0bTULVulzGL1CLdkiAElSTpRlV5MSNOzASWPv+es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FgWIybPP; arc=none smtp.client-ip=74.125.225.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FgWIybPP"
Received: by mail-wr2-f28.google.com with SMTP id ffacd0b85a97d-485b1d2874aso1446051f8f.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 02:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790241175; x=1790845975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0T6gy4Aw3WfHFoNTCiQ4B3uP/bh3QfbEnAm8LgQjvIs=;
        b=FgWIybPPwptnGoIMYOj7kdxjQrBorZKG+GaAjJrLTGeUftBhTV3d+SI23asRa+NFwg
         I3jExrtk+cXsFIDIuHWylnuAaVx78XEHGz5AAa/WuIkT+MBlb91KRUWOVddZCUv38i98
         G+uDfnn2hMgcK82bdMJCaDmOtlUfVzC8oFZy2dD2AxW5953XUe0XdyS+qwH+DmSCkwJ3
         dRG1GtI7UfF2x8BHqCinLwDhj8z/bPOuPEKXQ426y9I96ucVMvmz8ikXDu4nDt5ri/MA
         XY1DZcBhfJh3lw3UF2Nlo1OuFrNLJEzor1KBncDMWjEGpToTNgCZx0A8vauo8UJ3y1cL
         HY6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790241175; x=1790845975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0T6gy4Aw3WfHFoNTCiQ4B3uP/bh3QfbEnAm8LgQjvIs=;
        b=YQlq5HRVlGL1dQT0EmmuCHlaugbY74Bfl32yWRXS25GKLV6HfsiOdNMRIQ20+yimdF
         W/QfwQnge4O+Sj8tr4E3+edJPFx9g5fIbzRqoVwzUL3q98FoxpLukdd4gswW9a7XNDst
         2hHJAWu3nhriVCc4EtPeyZi+LgWavMhLo3oY6lwu461aQnNawn3mQxoq1eRY5pWpz4Kd
         kercxKKbG2XT2mVrDUVWefQazpd9lleYsB5aZ848OXzHQUSlqy0Op/XyJSbhDttO1y/a
         hzI5duEyA85yXCzogy4DbLIx9TH9rfcXtiU0qm3NtD8XRNTWDlw0ZVwNSxZmxvfD0wZT
         Uo4w==
X-Forwarded-Encrypted: i=1; AKwUvBwyqMJiHhPB7LN56Pnydbbhe+bJf/YIS3s2xs+brJ51auYjeiFABVjSSF1oGQVWPlzVGkK+XAo=@vger.kernel.org
X-Gm-Message-State: AFuF++kmSProT4VXpf1NtLAEqU1g/gIyVMV9ogJR5x+YnDB7TucreD7J
	G3iezjcGB8nBo12KV4iKDMfHQ90tt2f+DxU7mV4oDLm5S4rPLI5nAloL
X-Gm-Gg: AYBFou1i8q4C/7RiXI2bneyvKtVUr2/bID6pKgGR1VsQL3Tm4qCbJFotRbiir5b18r8
	L7QNu169mcU5AwdGWABHFIUQX9DujlxNufOiISXog/epUstlsMtPkt3BwWavkd+2WEjKd1aBoXV
	FO/cijxfaWsEv3sTevSe0WAWnfrFa0yQMyInuqZSw1iZYT0Qumvbl2TQClKxOHOFBPxRGb32SDu
	DtplzEzAUR109UgtGC9mjvxLzoHYkZp8LSpgRvHvV4cO/BDJB9Y2ZtmSQn2K/CFV/8RDDjjsIvR
	kP3AKI0vYMpV1QwEqUFPc3rcKDkgtoyRHw6uYoAMk/aqR25r7zmZ1VvgFaHi9xK0wJp/2ojh6iI
	bIPJlE8lSmRJZ4tPXHTjwg/OjnFEyQ4RLf21PAElr9EG9HmoB+DjPtqus5GnzwtJzV3t0Zl8XM/
	3EmPI7qAT757srF7rPwc+QbC0PFof9RL6gUe+MiwYa0OAm5JCz3nLn8YFrkt4kZft0CdHdi41Q7
	VjtDjiCAuIdjA9hcvyMGyNYDXM0csl31PuFyyIWM43BB6A2CfxD7bIAIDfGq43sQFVJBNnsS/Ya
	kRuT
X-Received: by 2002:a05:6000:604:b0:487:d60:aa69 with SMTP id ffacd0b85a97d-488716b74a7mr3595554f8f.7.1790241175505;
        Thu, 24 Sep 2026 02:12:55 -0700 (PDT)
Received: from andreayoga.localdomain (93-42-14-189.ip84.fastwebnet.it. [93.42.14.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4886848636asm12756677f8f.6.2026.09.24.02.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 02:12:55 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>,
	Brian Foster <bfoster@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Dave Chinner <dchinner@redhat.com>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/4] iomap: don't resubmit an ioend after ->writeback_submit() failed
Date: Thu, 24 Sep 2026 11:11:51 +0200
Message-ID: <20260924091203.198225-2-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924091203.198225-1-parri.andrea@gmail.com>
References: <20260924091203.198225-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iomap_add_to_ioend() submits the pending ioend through
->writeback_submit() before allocating a new one for the current range.
When the submission fails the helper completes the ioend with an error,
but iomap_add_to_ioend() returns the error without clearing
wpc->wb_ctx.  iomap_writepages() then submits whatever wpc->wb_ctx
points to, so the already completed ioend is submitted a second time.

For XFS the second bio_endio() lands in xfs_end_bio(), which
list_add_tail()s the already linked ioend into ip->i_ioend_list.  This
corrupts the list and leaves a use-after-free/double-free window against
the ioend completion worker.  Reproduced with a fault-injected
->writeback_submit() failure on a reflinked XFS file with several
CoW writeback ranges in flight: the unfixed kernel hits repeated
"list_add double add" warnings from __list_add_valid_or_report(),
the fixed kernel fails writeback cleanly.

Clear wpc->wb_ctx when ->writeback_submit() fails.  The old
iomap_submit_ioend() cleared the context unconditionally; that clear was
lost when submission moved to iomap_ioend_writeback_submit().  The final
->writeback_submit() call in iomap_writepages() needs no equivalent fix:
it is the last thing the function does before returning, and every
caller allocates its iomap_writepage_ctx on the stack for a single call,
so wpc->wb_ctx is never read again afterwards.

Fixes: f4fa7981fa26 ("iomap: hide ioends from the generic writeback code")
Cc: <stable@vger.kernel.org> # v6.17
Reviewed-by: Brian Foster <bfoster@redhat.com>
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 fs/iomap/ioend.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/ioend.c b/fs/iomap/ioend.c
index 7bbbb417f9152..32ae292a84cbe 100644
--- a/fs/iomap/ioend.c
+++ b/fs/iomap/ioend.c
@@ -246,8 +246,16 @@ ssize_t iomap_add_to_ioend(struct iomap_writepage_ctx *wpc, struct folio *folio,
 new_ioend:
 		if (ioend) {
 			error = wpc->ops->writeback_submit(wpc, 0);
-			if (error)
+			if (error) {
+				/*
+				 * ->writeback_submit() completed the ioend
+				 * with an error, so drop the stale context;
+				 * iomap_writepages() would otherwise submit
+				 * it a second time.
+				 */
+				wpc->wb_ctx = NULL;
 				return error;
+			}
 		}
 		wpc->wb_ctx = ioend = iomap_alloc_ioend(wpc, pos, ioend_flags);
 	}
-- 
2.53.0

