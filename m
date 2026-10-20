Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792511798;
	b=s7j95tIYUMkEMlOjJavhzjTEDRmjVOPMZIk0+hu2VU5JE9kteJoZCeZjKD3KWIv/rk/R
	 7S6MaD6u4HI1WDK+TVTxyzTQnLCibMC6Uc4cjcFev7azSanNkThPBkO0BIjlLXhaN9eX8
	 nHhGPfWnIzFA3tGgEu88Ltk4A/xHOEGEDg1lai2286YpuRHWFa+ZjAJTfF/OSPzohh2MD
	 2WGWmCL/9lLj6EyLKg8OYYT/7C9itdHBryyYrP5Ah/ft/ZkrV5ZODARtqvnnVejJmmBSp
	 V0aHihfXomNlXKnKgC6yTC7kK/Gp9UoJ+zy5hQN/WxZ9pKB2o1km7UhTR+nXOwaYVlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792511798;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=L8qmWO61wdm7iL9HYvTsb+/C7jTjPJIX6QKiCsncK8k=;
	b=l/w71EwU1hOpwnWdeGeG/4Uj6i9YLThKs7PuiNwSd1PohTANtOVuiJFmf3cGShD+SW1D
	 SsRY+mDl3n9mfOHDGijCj0dy3JDyb1lK94T47S28lRGENEGjPHCp7F6cN7TQzlZAE9hzs
	 YGPoazh+NNj1PRU1cpll3BNYZYMr+rQa+erVxFVZC6UUBHrpwPIX6iYTvuAZlptRxAYmd
	 4dVvZskJGEQZ6lLVWel7LR+uERcFIRMcNmJACu3Z9FK4ws43Q5L/pKoZPT0y5aGSXH9e/
	 kKbC1/WPjwD93W2G0K3Pg2WiruJRa7lqsDRGS9Ta5W68vTMY0O2sKf36zhfImXM4gtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 72928606A31D;
	Tue, 20 Oct 2026 15:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 85C351F000C4;
	Tue, 20 Oct 2026 15:56:37 +0000 (UTC)
Date: Tue, 20 Oct 2026 18:56:04 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	stable@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] KEYS: Expand key->{datalen,quotalen} to unsigned
 int
Message-ID: <atePFBHs_bQJKN8f@kernel.org>
References: <20261020013903.1244157-1-jarkko@kernel.org>
 <20261020013903.1244157-2-jarkko@kernel.org>
 <20261020154714.GA699485@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020154714.GA699485@google.com>

On Tue, Oct 20, 2026 at 03:47:14PM +0000, Eric Biggers wrote:
> On Tue, Oct 20, 2026 at 04:38:55AM +0300, Jarkko Sakkinen wrote:
> > diff --git a/include/linux/key.h b/include/linux/key.h
> > index e40b5267658f..26139c3adf62 100644
> > --- a/include/linux/key.h
> > +++ b/include/linux/key.h
> > @@ -216,8 +216,8 @@ struct key {
> >  	kuid_t			uid;
> >  	kgid_t			gid;
> >  	key_perm_t		perm;		/* access permissions */
> > -	unsigned short		quotalen;	/* length added to quota */
> > -	unsigned short		datalen;	/* payload data length
> > +	unsigned int		quotalen;	/* length added to quota */
> > +	unsigned int		datalen;	/* payload data length
> >  						 * - may not match RCU dereferenced payload
> >  						 * - payload should contain own length
> >  						 */
> 
> fs/smb/client/cifsacl.c contains some debug logging that prints
> key::datalen using the %hu format specifier.  Those need to be updated
> to %u to match the new type.

Ugh, my mistake i.e., we are talking about:

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index c5e47a835f99..de2acc7234be 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -385,7 +385,7 @@ id_to_sid(unsigned int cid, uint sidtype, struct smb_sid *ssid)
 		goto out_revert_creds;
 	} else if (sidkey->datalen < CIFS_SID_BASE_SIZE) {
 		rc = smb_EIO1(smb_eio_trace_malformed_sid_key, sidkey->datalen);
-		cifs_dbg(FYI, "%s: Downcall contained malformed key (datalen=%hu)\n",
+		cifs_dbg(FYI, "%s: Downcall contained malformed key (datalen=%u)\n",
 			 __func__, sidkey->datalen);
 		goto invalidate_key;
 	}
@@ -403,7 +403,7 @@ id_to_sid(unsigned int cid, uint sidtype, struct smb_sid *ssid)
 	if (ksid_size > sidkey->datalen) {
 		rc = smb_EIO2(smb_eio_trace_malformed_ksid_key,
 			      ksid_size, sidkey->datalen);
-		cifs_dbg(FYI, "%s: Downcall contained malformed key (datalen=%hu, ksid_size=%u)\n",
+		cifs_dbg(FYI, "%s: Downcall contained malformed key (datalen=%u, ksid_size=%u)\n",
 			 __func__, sidkey->datalen, ksid_size);
 		goto invalidate_key;
 	}
@@ -498,7 +498,7 @@ sid_to_id(struct cifs_sb_info *cifs_sb, struct smb_sid *psid,
 	 */
 	BUILD_BUG_ON(sizeof(uid_t) != sizeof(gid_t));
 	if (sidkey->datalen != sizeof(uid_t)) {
-		cifs_dbg(FYI, "%s: Downcall contained malformed key (datalen=%hu)\n",
+		cifs_dbg(FYI, "%s: Downcall contained malformed key (datalen=%u)\n",
 			 __func__, sidkey->datalen);
 		key_invalidate(sidkey);
 		goto out_key_put;

I'll include this as part of the patch exactly.

> 
> - Eric

Br, Jarkko
