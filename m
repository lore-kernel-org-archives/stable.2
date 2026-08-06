Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9BA46EC6C
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 11:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786016206; cv=none; b=NHOr9IskZHlsxHnY0H0GWzyvULCECzWBhQEbiy3KakzPPOnlZcvu0C0+D3i1Qcm46dLunWQfBUR5JpW8OA2ss95ZwaGRrNenOKShV+adq7P8ikugwIX9/fRlGcmcN8SqYrIufOmYPbti0gD4AVlMj8QCaSDvj7t4PgpWGIqgdt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786016206; c=relaxed/simple;
	bh=UM2PD0ECic7/+rrCj2zxzyOuefMYN7aKewIB6pSVgO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUbXCuA2C+tfZ8CxvTnAlh4S+VEhM+56IxxhiuPkbVGDqatZFjgXrLfmEaY9Q/wNLu+ufaD4VNxT9IA6iv2vnWmidPzREQk/rnt0Y7MZIdwazc3R13KJlk/stTfKg29j95PlJeb/OXYMHt5/0lAMQkhvYdJtJH/V2C2BHEZN0B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cXCvPRit; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cXCvPRit"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884A51F00ADE;
	Thu,  6 Aug 2026 11:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786016199;
	bh=SX5UmpnnES4j8Sc/YKEf7geRNKpAI4dQy7OVxbZ/tlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cXCvPRit/wh+m/rlLjcNyfIEjbJpKsCxlO5XeUf80l+APDQcd/kIuEqHdgbOg1ZfM
	 Fb8DYVPHDLTdqrLswBlLGrbMHYEgMlf2RharHxdxv1XMAY3udBwclKQ1d5PhNRiOqN
	 pb4ucPdBy7ijKdJFPXEDy+xQBcwdjjxmrUIh7UcwqK+fZsvaODNr1bkmqvQYGvPlxY
	 NQISCxa9kMxdOwytbGXNoPIRXv+lEjbyoTRENg1SUKa4zuSYNCrpYf/JBRRLNYqkyi
	 PBHzeAefgZbdtG+EZm6RShNPaSJQIRQYmZWgM77k5porLEqs1+t44xaP0VwQjVtY3a
	 vcgR3Lfz5Lgcw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Ilya Maximets <i.maximets@ovn.org>,
	Aaron Conole <aconole@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 5.15.y] net: openvswitch: fix skb leak on flow key update failure during recirculation
Date: Thu,  6 Aug 2026 07:36:09 -0400
Message-ID: <20260806021809.0016-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805222008.2820396-1-i.maximets@ovn.org>
References: <20260805222008.2820396-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Aug 06, 2026 at 12:20:07AM +0200, Ilya Maximets wrote:
> [OVS drop reasons are not available in 5.15, hence plain kfree_skb()]

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
