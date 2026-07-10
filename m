Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEB52D0C7E
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 21:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783717409; cv=none; b=qtrgruXlDLmmkyHdTZpdpmVGifJvYARdVC3SDGPXxTmyAG8og0V2ZMwmcYCc9CLWx5qq0E2Ydscc7ODRxE+1erpBDzDckLsdw42dxZ9Dfx8h2jH/d/dO7OyMCRNTysJ/worSvc7hwkptxY2vBkqjLOREQlxnmQk+0+cisDdYFR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783717409; c=relaxed/simple;
	bh=id5Jrb4hjj4X9qHIQpsV7iB6ee2NGuw4Uh8wjv8jPS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OoJIo96gHmObN1aB6DggD2pHN+axMeYPjeQvAfk1IIDoBZmbHh77TqRN4g6jaibkv6ukJOowAyyiCiaYGH+ruynyRI8TkCeJH9QKfYueABM7b+guUgh/Afzefa9p5U2lN/s+YdGaWwxQgJqU0k2CxgB0fd750z1cnn+oHq0KfZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A57ajD6z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A57ajD6z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1201F000E9;
	Fri, 10 Jul 2026 21:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783717408;
	bh=LNf8tTx8ooX/swGjtYWyFyAfolkS3ym38KFhiBoPDOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A57ajD6zoR5JKl+cygQJo/acVDH+Zfl9/C6Tgq0rEL0rx/ji8G2w3MyaASQiljqgc
	 NYcWwrx1NK58C/j9r7hPwbi4FZ2A01epeQup94nL+ADYTSS9rdSMc4LjV6S5XQJgqR
	 w3SDHLoGOmA96WAE8NQvHpWwigFU5T0sOfv4z9+Q95/jAWEkrRetLvDxxnUCvxKEuj
	 CLQwgRCcWGq/cEa5lI+JrXixea57gaLBfV+vBKKaLzjOTYIQ+cqUUi2OLEj6vO9eQd
	 kjTlNzdNREWsQZ0bwevcHJd6sGiRV7Kp6x2dKS1Rqf84WDtQ/QccWqWmicH0jwpWrz
	 QSOFx/BpgSM8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Joe Damato <jdamato@fastly.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Hyokyung Kim <pulpannie@gmail.com>
Subject: Re: [PATCH 6.6.y] virtio_net: Support dynamic rss indirection table size
Date: Fri, 10 Jul 2026 17:03:01 -0400
Message-ID: <20260710163023.agent5-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260710111954.234758-1-pulpannie@gmail.com>
References: <CAGJdW3H0Bv31W5DNaHstXyYxMcVFUnOmzAJ9LAjZOANk1y67OQ@mail.gmail.com> <20260710111954.234758-1-pulpannie@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, Jul 10, 2026 at 11:19:54AM +0000, Hyokyung Kim wrote:
> However, the indirection_table was statically sized as
> VIRTIO_NET_RSS_MAX_TABLE_LEN=128, potentially causing issues when
> vi->rss_indir_table_size exceeds this limit.
>
> This patch implements dynamic allocation for the indirection table,
> allocated alongside vi->rss after vi->rss_indir_table_size is initialized,
> and freed in virtnet_remove().

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
