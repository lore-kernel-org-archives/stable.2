Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5451E0DD8;
	Sat,  5 Sep 2026 19:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788637142; cv=none; b=QM8BrTttWvZkDl4ImilGK26ykzD6hUzjg32v91HIBBeczlli4QCvi1G2v7EUUgwbr4pmTz+c6QAr1dMM2Ru+NKnmQ1YgvTJdgfQVm+TrX/MLtEiN3AgNqhKBAeVlTwa/o3zvSg6FBdX6LQl+Jg/99XdTFBM7IsOpLNuiis5B02U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788637142; c=relaxed/simple;
	bh=SF1UnUaMSoDUh8cGwnjxvVJLumAGug+SGl3MGqxHz3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f7sxq9D8priqYDbhe0W9mNpzDsdRNEW2Wikok3/bKW+/05+4eFx9mv6cDlYKT8s4IcczSTsgIyn+yCad4bTfelpWPe6eH38NjS4mYV2q7fuygl8Taz5QSY51rXDz1POdhIoHp1Z9Q9sW3V5x9I1fKif0LIyROm5prlpLJNgHTyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOz0W8l2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOz0W8l2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468721F00A3A;
	Sat,  5 Sep 2026 19:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788637141;
	bh=7uQwcgk4iyBn+0+c2PKDLy0bjSpSWQzGOEaTS7hkGrc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aOz0W8l27nbvbNIuDirDzTgk2vb4pbVNtzdpw3sgTpBQwrkvkOEpWbmTn/ySNqaT0
	 fdWRAT/4hi65JNjPQsQjBfYsl4QRO8sXhIe3iFnveYL/IiJSU/TI1tS6IW47w6FSYj
	 CdQN6JdNaXWL486GjAx+TByGBmLL6RchQ7Gzi6maFYQmxbujxgJ8Uh/2Ha/YUxslsO
	 Meo/vI+TCHVsjXQ3Ckd1rYkpPuv7BHoDxRtyfim0gbSSyNt4VuWzAdq4Pt19thBBxI
	 BsIpGgOwvcn/nTa22W5c78P1/JWaGLvNE1rbxKaIyHQSeMfInsLqDyvFg4VYk+jZbD
	 v0cZ8Psa9YPyg==
Date: Sat, 5 Sep 2026 12:39:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: alishmery18@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch,
 idosch@nvidia.com, razor@blackwall.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] vxlan: vnifilter: validate the VNI range in
 vni_filter_entry_policy
Message-ID: <20260905123900.23984eda@kernel.org>
In-Reply-To: <178863701124.219967.14305621519981687842@kernel.org>
References: <20260902154609.594009-1-alishmery18@gmail.com>
	<178863701124.219967.14305621519981687842@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 05 Sep 2026 19:36:51 +0000 netdev-bot+sashiko@kernel.org wrote:
> > +	[VXLAN_VNIFILTER_ENTRY_START] = NLA_POLICY_FULL_RANGE(NLA_U32,
> > +							      &vni_filter_vni_range),
> > +	[VXLAN_VNIFILTER_ENTRY_END] = NLA_POLICY_FULL_RANGE(NLA_U32,
> > +							    &vni_filter_vni_range),  
> 
> [Severity: High]
> Does this clamp close the problem the changelog describes, or only the
> U32_MAX endpoint?

I tend to agree, either this is a security fix and we need a stronger
check. Or it's just making things slightly better and doesn't deserve
Fixes/stable.
-- 
pw-bot: cr
