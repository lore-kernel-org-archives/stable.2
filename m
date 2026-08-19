Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE3630FF2A
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 03:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787110354; cv=none; b=lQrfAbVwR3DDKThaAOFoJSeDQMl83IFHi3yXekPjvGb9JOGs1a9C6tgc0AOeX1WJS8CeVz3hQ+LRvkLaA+/jtJqrC9BPnMTaUl+bVneHm0qL99VYLFscKVu4x4lwVyC52RRT6ZEg5ZlZdWPIBSaL5e8VSK74NRAWrEL1+KMqyLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787110354; c=relaxed/simple;
	bh=eo8Ea+ogGidsutiQkGTDCrfl6JLk4J8pcIiSN/6VlaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5+5JItBA8NC6DaZuXVgtgcY1G4KDpis+CQimHQ4EoQN9VXMemPwWcbH14KNnHRKVaSfC7MFbxDgGZe8KtgRvmgfP0GaUiHxuvirgVQCfjosVNeXz0KnoLmGkHjgxRlEpkkVqoc1YvAJW99xNwFEUqKVizKFIowHb1sSm7NwmS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TqPmkPYc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TqPmkPYc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3EF1F00A3D;
	Wed, 19 Aug 2026 03:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787110353;
	bh=sZyqB/IyqP3H6TMsNHmYPhB5+IjfwZeZzI9F0ZU4gPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TqPmkPYcDhLa+5HahWsBpqaEf+U2S90i5fVj6Qlsb9mB56OE/iO3a7nndJDMGAg0k
	 8EFS2T60pzVjK7Kp3Z8VYa3MA/H2jaNd551rKpe+maXTXWA9hcYR+QjrJBxEDzvxq1
	 8I0KwfHkxcG0GvqHOJv5Jk0UJViBitNJCU1M9JJR1WfpuGnJrH49IDAGPWUjobrrRB
	 Igc0ovQ4TotwVlBUUgGMvi2Q4E8iQNrbmgTFuuEuiy1pR5lDVd7cVNcGX+smYk4DOV
	 zrCCBXrCyeAnEZoEqizYgea5NWbGEWHgpu+Ni6y0+hPTNz2n0aqqrMx1WHp/X8cZVN
	 Fw8bZ4QJXCNbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	alifm@linux.ibm.com
Subject: Re: [PATCH v3 stable 6.1 0/5] s390 KVM PCI backports for 6.1
Date: Tue, 18 Aug 2026 23:32:16 -0400
Message-ID: <20260818220420.2@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817201606.3194-1-alifm@linux.ibm.com>
References: <20260817201606.3194-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 17, 2026 at 01:16:01PM -0700, Farhan Ali wrote:
> This patchset backports the s390 KVM PCI fixes to stable-6.1. The patchset
> includes one dependency patch (patch 1) from Jason Gunthorpe, to export
> free_uid(). This is needed to resolve a compilation error.

Queued the series for 6.1, thanks.

-- 
Thanks,
Sasha
