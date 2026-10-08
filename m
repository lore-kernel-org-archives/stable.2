Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148A73CB570
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 19:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791487255; cv=none; b=IEwFG1Uum4RR3dDFUvNXXIExQ+GS18wNfka6vV8iI9uQS66Q0/0FfGsaPwHOm//JcyicnGSsT+oThw4oC0s2nrFA3mChbm9JI3oSgMVELXVhG/i0ijplqnM/A6DHfQ+akI4kWpcoaBrG3TMwOlK+svCdRiD6e53XG5DX6TS4nVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791487255; c=relaxed/simple;
	bh=fyyWB8kFM8yS/sTHX0FEktjdZHa2MY6B79uzjhYFx34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sj2NSAhou6vhkskRuLh5IN696MG6/CLaN8Kmh+Bj9nC2MijR4VTKA+Nl0Iq1X+yt3xIYxcseTEiQz9dEz0QScm0U/NJFaajdG7MNj5+nsKkoMKuAhDKYT5I3/fnz0UlZTyW4kgL0cwAvTSWjH9IaTBFSRA+SexZ6QjXzhaPP86k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=TN9me1t1; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="TN9me1t1"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-33c2520ad38so8070012eec.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 12:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1791487253; x=1792092053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=auJr1ryaFMZM/c/xY8k4emAnc/zPgD5/4eqsxgMghaI=;
        b=TN9me1t1qFKcXRB3KH8/j2XFMzejMhSFQxpt3bbiK79fgxV2idBuvwElOaJ9cw4ivP
         a3N2+15TlIglpdv06cgYtO/ABQUC6QQFd2JHqotYeFFKj+w/ehBGByhvfhfsDxV8jFP/
         gLKPJVNNnA33HFzb1wm5asIRYHE+nLLySUkuOrBcLqSgz4xCu+YfICOSa3q2FG1CZ4kE
         /VR6Sip1Gdx+Sa9eQpaxSDdHzvVVqCHebIaOHHLyPBmwKIUTDipfj9dfSAzDZ6G8wTOP
         wTrxKOt9N5F5XA17MtkxYzpsDSwq+ZFyp7Do7OGcfigQxpi+YdvgDiICU1BO7gNGfJu/
         Sc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791487253; x=1792092053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=auJr1ryaFMZM/c/xY8k4emAnc/zPgD5/4eqsxgMghaI=;
        b=c3ID7u0hi3TftphL2KZ+6WiojJDGih2rVa1cGz2VCetkn5FTAgkIe0tz7Gc5ImfXxT
         q8iLyNYPIwzJsj0miArz5B0SDa+XS385R54FnpsaqzcHWcDWxvsbuMvzAkUMrrLFN+HK
         +tlPAYXgol/3clZ4hYsGFwfOAinQ9Ty0nyl7VfMRdGXWpCyp8vk4WSHwMIx4cRHCcyzS
         lCtIK+RaG7kCmsQURMovEHQPmAxUGgXoZVG7vfrlB96MB7gxd+Ui1OLKL4BeXw6/9QJR
         QRVCP2N2Jv6iNVPjP5tR3UwSLH9TogfV4FRPxWn2cspgr4FvJPzduUxE5iXrO6GkhMpn
         /CQw==
X-Gm-Message-State: AFq9FYLZLCxDwQfn3PinTQrvFaU/VraqFpHtHFOMIM0lcTgeuraxVPVb
	akDg65Pva9Wy2BLvGDE3+mTc+qGdx1TkOJB/PB8dqvmEP0i/WVm/0HFi8+ABVppzqPI4oFEESsl
	JXcBhnIQU6Q==
X-Gm-Gg: AYBFou25XD3+KSI4xw3BKLnltyV+3UAS1t/pjwGIhTrGjfBA8YUxgZGHjzu+pLKQhE0
	Q1c8bISH4q7HXZ2/qTPlyuRhVfnZUchp3MEjLUpBll98kzAQU38vk0xLktuAxz6yDZrS3+TjK8v
	fWg+tt2jYS8quxjMFH+Oahj1WtCYuj2fW63W73HJPi6vB4mAcEYalrAVMYghdLGK3Zy/Do/pO7u
	5iIjEsY1YCljk/dnAeblqVaw6sZYSrqEJstiIX1BWFeh12sj2QRNb9o605YZ/uN4sCFu+kSWQ3o
	RwU6/N/zRcf4ndd12xo4jW3x7o4Zr+9/38XTUy82aBA9bTWa9mCJ/+Ki0KedMHpPK1db+QC+rRv
	mVbRYcliX8uV++LcAFcH/kqjD42/XtzBaLe+In9Q0jJZY2ntPJIRIutfxKPWz5D1blMv3kgbMZx
	Xzjw3lufwdccONMWZQhvbYcozhk77xrnCVDvNjF+dR6u9YL+dFxbcMYOKixXylT4Rul6xJVQL4A
	wBIwGIH6YHfXEOLt0QasdoTz8w+512SKk8U76CngB/UKDKvbHdpU+9GyhnARYH1qIT2x9Y=
X-Received: by 2002:a05:7300:6007:b0:351:7108:c62 with SMTP id 5a478bee46e88-35171081ee4mr4681951eec.23.1791487252953;
        Thu, 08 Oct 2026 12:20:52 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:bc88:5ec1:4f8a:5b23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca329d9sm104325eec.5.2026.10.08.12.20.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 12:20:52 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Max Kellermann <max.kellermann@ionos.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.com>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.6.y 1/2] jbd2: check need_resched() when skipping busy checkpoint buffers
Date: Thu,  8 Oct 2026 15:20:45 -0400
Message-ID: <20261008192048.98833-2-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008192048.98833-1-artem@trailofbits.com>
References: <20261008192048.98833-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Max Kellermann <max.kellermann@ionos.com>

[ Upstream commit f213e12ff5c9590b1034ae8da0e6d09665c772d0 ]

journal_shrink_one_cp_list() skips busy checkpoint buffers when called
with JBD2_SHRINK_BUSY_SKIP.  The continue statement on this path also
skips the need_resched() check at the end of the loop body.

Consequently, when a checkpoint list contains mostly busy buffers, the
shrinker can walk the entire list while holding journal->j_list_lock,
even when a reschedule has been requested.  Large checkpoint lists under
memory pressure can therefore cause long lock hold times and leave other
CPUs spinning on j_list_lock, resulting in soft lockups or RCU stalls.

Route the busy-buffer path through the need_resched() check so that the
shrinker can release j_list_lock and reschedule promptly, restoring
parity with the clean-buffer path, which already checks need_resched().
This does not change which checkpoint buffers are eligible for removal.

[ Backport to 6.6.y: Use this tree's older shrink_type enumerator names
  while routing busy buffers through the existing reschedule check. ]

Fixes: b98dba273a0e ("jbd2: remove journal_clean_one_cp_list()")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20260713102229.1598812-2-max.kellermann@ionos.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
This is patch 1 of 2 in the ordered 6.6.y backport series.
This change addresses CVE-2026-89566. Both targets skip the common
scheduling check on the busy-buffer continue path, allowing an unbounded
non-preemptible scan.

The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.6.y.
This fix also affects 6.1.y, which will need a separate backport; this
submission contains only the 6.6.y patch.

 fs/jbd2/checkpoint.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index 32ed28cfb3a0..e8a7186eb8c3 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -391,7 +391,7 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
 			ret = jbd2_journal_try_remove_checkpoint(jh);
 			if (ret < 0) {
 				if (type == SHRINK_BUSY_SKIP)
-					continue;
+					goto next;
 				break;
 			}
 		}
@@ -402,6 +402,7 @@ static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
 			break;
 		}
 
+next:
 		if (need_resched())
 			break;
 	} while (jh != last_jh);
-- 
2.39.5
