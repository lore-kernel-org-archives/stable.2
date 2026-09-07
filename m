Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4749229BD91
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 01:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788744163; cv=none; b=azq2y9/UNnXjd9cjjwcFv+AVujkiP7WkIWPX2SMut9KxkvmelQqis2eWRkrRa0aJ2z81xi1C6xnhTkHNJO5t4BR3wkJMncJ/JMIJpHzWMMQjzyifAl3xIw8I3JO7bXuZptlCjbo4QTj68+tYTOTr5ytb534fp7Z08csFf1P86Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788744163; c=relaxed/simple;
	bh=exrMdwZEi67yJ/Tg5U7RUO8GHbhhsudeAMAqV37v5rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EEeZ/GCisCTumDZ2Y8r8CC4m/3CnRWATJGnz3G9GRocPZtDWUPMZgWpb/OmPx90bLfXCjSRL1CeWDiA+PN2wlOjlqyHTm0KmMqsVvoWOHkV0AxeIfP9f+Fxbk2isUU0KkJ9JBCdCsx7yTTObNn6wfWP+oY259oXqMehAJtip4FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7KG3cGs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7KG3cGs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E581F00A3A;
	Mon,  7 Sep 2026 01:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788744162;
	bh=CDnmQ5Wca6LRnm7oaPmjgFw+cMx6ENSEvqMWXjBYlPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y7KG3cGsTogGxUX0S6ermZqao6HJUybzrhh3DD61EeWjHST8SEPpgmHb2TehsXAcM
	 rGEDhTdf792i80scewAa55+3B8TXOI/PZ01WlzinoeooAF6nsFWbhuloLeNXjZkFby
	 BfnOo6Zs5fpl2AeoaspAIkQHBkhxLaT+UKbJoRRMu+M5Y5hwHzF9z53fIfR0OA3KDi
	 +RF20nWVfiXODrXi1UJPgP7f/EkAOEc8ksELEQOuL/yv9iq0NcsgMQBub9PoYvqUcA
	 pEbwRaAco5CKIwYQcS6umlByhy7OhXJ655Ash1ZtcnsVj7mTAb05gtqpkwyPyr22Fb
	 kVE3gd7Wom9xA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Sun Jian <sun.jian.kdev@gmail.com>,
	Youngjae Kwon <yjkwon0026@snu.ac.kr>
Subject: Re: [PATCH 6.18.y v2 1/2] fsnotify: inotify: pass mark connector to fsnotify_recalc_mask()
Date: Sun,  6 Sep 2026 21:22:35 -0400
Message-ID: <2026-09-06-daily-reply-0005-fsnotify-mask-6-18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906030833.3356045-1-yjkwon0026@snu.ac.kr>
References: <20260906030833.3356045-1-yjkwon0026@snu.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit 4520b96b8136ba2465a3f4dc5c3fb8bdf3d92e4e ]
>
> fsnotify_recalc_mask() expects a plain struct fsnotify_mark_connector *,
> but inode->i_fsnotify_marks is an __rcu pointer.  Use fsn_mark->connector
> instead to avoid sparse "different address spaces" warnings.

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
