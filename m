Received: from bifrost.moepi.net (bifrost.moepi.net [167.233.64.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B627436E48B
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 19:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.233.64.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786564322; cv=none; b=jQMjz8uShlUHO6g/w5AF8LL7JvW+ev37bZyt1tytrFbMX7G1UUL6SywMi1EYJ70J8kTjL2GbrZiy7q9t00dKPOcusxMtBTuhLR7dk4owVtgpDqEg0CvZwwAEAeMgOUyNEx34JdJGZAmXisv5KFpoqFJ0pTpriowbTAJo4+JZ9ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786564322; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AIg5CcVFL26PpkbjyAgWF0MKBexusO7f+IkZpA26oL8Xp6zwaIMzT3mNGjqQJCcRLzLSHg4U9yT15DtA2uyr/jjm+pJWiEdeWYkfhxCMrB2s6WtI4lD4cL6mvz0D8bK29efvtg1lgyQ/DNRzHCOCKkEuO5xrt88lU7VqXyVQh64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=moepi.net; spf=pass smtp.mailfrom=moepi.net; arc=none smtp.client-ip=167.233.64.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=moepi.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moepi.net
Received: from moepair (unknown [178.24.249.159])
	by bifrost.moepi.net (Postfix) with ESMTPSA id 996A5611F5B6
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 21:45:22 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by moepair (Postfix) with ESMTPS id 01E582268DA7
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 21:45:21 +0200 (CEST)
Date: Wed, 12 Aug 2026 21:45:20 +0200
From: Stephan =?utf-8?Q?G=C3=BCnther?= <moepi@moepi.net>
To: stable@vger.kernel.org
Subject: unsubscribe
Message-ID: <4155de976923753f8af567e63c169ff3@localhost>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

