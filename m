Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3F937B025
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 02:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785379245; cv=none; b=bFZf3SV7RWUSrDr+Js4D5vj0BLcbPdtddsNhOppx0s+9MzVdT3sIKwnwKD4jwTx1PmEG5/yyj0gmpEo4fDdgordtHV6Slcirwiku97a4LTedhAL8BfAO2mVskY4XEiI4cOVAim8DC7QQMEts3IcpHKDTq+Rq6kNZyZgHO6ZQjkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785379245; c=relaxed/simple;
	bh=tKYKIqQ+jcCSErb9GJaMjnegh1aQ2/8qZ7njo2erMdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TEMKnRqgN7nnAndCEmEQKaHPP73mtW/YOooVFY1/Vf4GbIb0Ar51dBdrLsclI9uO63xxhw1ElnIL/wXY0wNWevK6fcQb1oCY5+82N1XLZ+cTGQd/O4yk8cN0aAhiAy2v28TiJ5RFZtqkPSPzoCMtEgWmtETryJPWYyT6P3djhfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWa/Q5e1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWa/Q5e1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3675C1F00A3A;
	Thu, 30 Jul 2026 02:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785379244;
	bh=x/FzjTugvvLSMwuTp43o4FzrnnXepwt7n+dv/+fhoik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eWa/Q5e1NQBm8E0eqQWSO+AKx8xl3+9Wg2+3ESlCbqcaJVV4pew90S3Ziodd3LLlx
	 5g1ulWEXFoRuAIWVdpLoVJUTI6V+YhtaBdRSbyqVoggb6eM43juPSjzHrTVXUgUzfM
	 Bz8tQGFAK+L7TfYNll89JdrNRivhohyJxz7w1nZFiq6dPokVx/LKd0RM1k6pY7XX+1
	 9SR+nwLVg/pmAedajYBl6iFFMIhhqSjFZ1jWiB7VM0NY3UoZFQgBZM1L8WRzb8MYzV
	 wecyS8IVaDP4zz3Qub0arWzEwyVb2NcJsp+ghrBQz9t8umyvx+BVsQ6dVhw03DDeFu
	 k1l3IEFuHM1Ng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
Subject: Re: [PATCH 6.1.y] net: qrtr: ns: Raise node count limit to 512
Date: Wed, 29 Jul 2026 22:40:10 -0400
Message-ID: <20260729223316.stable-0014@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729150958.3889964-1-youssef.abdulrahman@oss.qualcomm.com>
References: <20260729150958.3889964-1-youssef.abdulrahman@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> -/* Max lookup limit is chosen based on the current platform requirements. If the
> - * requirement changes in the future, this value can be increased.
> - */
> -#define QRTR_NS_MAX_LOOKUPS 64
> -

I've queued 6.18, 6.12 and 6.6, but I'm holding 6.1, 5.15 and 5.10 and
would like one v2 covering those three.

Two things:

1) The hunk above is in the 6.1 and 5.10 patches only.  It removes a
   duplicated #define that our own backports of 27d5e84e810b ("net: qrtr:
   ns: Limit the total number of nodes") introduced, which upstream
   ff194cffd586 ("net: qrtr: ns: Raise node count limit to 512") does not
   touch.  The 5.15 patch does not have it, even though 6.1 and 5.15
   currently have a byte-identical net/qrtr/ns.c.  Taking them as-is would
   leave the three old trees gratuitously different from each other.

2) More importantly, none of 6.1, 5.15 and 5.10 ever decrement node_count.
   The backports of 27d5e84e810b dropped the node_count-- hunk with the
   note that ctrl_cmd_bye() has no delete_node, but all three trees do have
   the delete_node: label with the xa_erase() + kfree().  So the counter is
   monotonic there and raising the cap from 64 to 512 only defers the wedge
   rather than fixing it.

Could you send a single v2 for 6.1, 5.15 and 5.10 that matches upstream
exactly and adds the missing node_count-- in ctrl_cmd_bye()?

-- 
Thanks,
Sasha
